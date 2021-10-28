--[[
  Title: The Phantome
  Author: Laura Clarke
  Email: 09.l.clarke.09@gmail.com
  Edx: __L-Clarke__
  GitHub: L-C-game
  Explanation:
  The Entity class
  ]]
  
  Entity = Class{}
  
  function Entity:init(def)
    
    self.type = 'Entity'
    --Setting up the entity's variables, as set in entity defs
    --position
    self.x = def.x
    self.y = def.y
    --dimensions
    self.width = def.width
    self.height = def.height
    --image
    self.image = def.image
    --health
    self.health = def.health
    --initial direction
    self.direction = 'D'
    --collision box
    self.collisionBox = def.collisionBox
    
    self.idleFrame = def.idleFrame
    
    --setting up the animations for the entities, passed in from entity_defs
    self.animationIdle = def.animation['moveDown']
    self.animationIdle:gotoFrame(self.idleFrame)
    self.animationMoveD = def.animation['moveDown']
    self.animationMoveU = def.animation['moveUp']
    self.animationMoveR = def.animation['moveRight']
    self.animationMoveL = def.animation['moveLeft']
    
    --entity type
    self.entityType = def.entityType
    
    --Invulnerability flag and timer
    self.isInvulnerable = false
    self.invTime = 0
    self.blinkTimer = 0
    --random direction for the enemy AI
    self.randDirection = {'L','R','U','D'}
  end
  
  function Entity:update(dt)
    --increment the blink timer unless not invulnerable
    self.stateMachine:update(dt)
    if self.isInvulnerable then
      self.blinkTimer = self.blinkTimer + dt
      if self.invTime > 2 then
        self.isInvulnerable = false
        self.invTime = 0
        self.blinkTimer = 0
      else
        --increment the invincibility timer
        self.invTime = self.invTime + dt
      end
    end
    
      
  end
  
  function Entity:setUpCollision(bumpWorld)
    --needs to happen actively
    local x_modify = (self.width - self.collisionBox['width'])/2
    local y_modify = (self.height - self.collisionBox['height'])/2
    --bumpworld location
    local xBumpLoc = self.x + x_modify
    local yBumpLoc = self.y + y_modify
    --adding entities to the bumpWorld, they are given some wiggle room so movement doesn't have to be pixel perfect.
    bumpWorld:add(self, xBumpLoc, yBumpLoc + 2, self.collisionBox['width'], self.collisionBox['height'] - 2)
  end
  
  function Entity:destroyCollision(bumpWorld)
    bumpWorld:remove(self)
  end

  function Entity:filter(other)
    --collision filters
    if self.entityType == 'player' then
      if other.type == 'Door' and not other.isLocked then
        --cross through the door's if they are open
        return 'cross'
      elseif other.type == 'GameObject' then
        --cross the game objects, these are consumables
        if other.gameObjectType == 'heart' or other.gameObjectType == 'key' then
          return 'cross'
        else
          return 'slide'
        end
      else
        return 'slide'
      end
    --the sword crosses the enemies while the player and enemies have slide collision
    elseif self.entityType == 'enemy' then
      if other.type == 'Hitbox' then
        return 'cross'
      else
        return 'slide'
      end
    else 
      return 'slide'
    end
  end
  
  function Entity:move(bumpWorld, goalX, goalY)
    
    local x_modify = (self.width - self.collisionBox['width'])/2
    local y_modify = (self.height - self.collisionBox['height'])/2
    
    goalX = goalX + x_modify
    goalY = goalY + y_modify
    --move the entity's collision box within the bumpWorld
    --make the collision box lower than the top of the sprite to give a better impression of top down perspective
    local actualX, actualY, collisionTable, numOfCollisions = bumpWorld:move(self, goalX, goalY + 2, self.filter)
    
    --set the entity's x and y to be their actual x and y as a result of any collisions that occur
    self.x = actualX - x_modify
    --resetting the y again afterward
    self.y = actualY - y_modify - 2
    
    if self.entityType == 'player' then
      for i = 1, numOfCollisions do 
        local other = collisionTable[i].other
        --render the relevant doors for the rooms
        if other.type == 'Door' then
          if not other.isLocked then
            self.gotoRoom = other.connectsTo
            if other.dir == 'N' then
              self.x = ENTRY_SOUTH_X
              self.y =ENTRY_SOUTH_Y
            elseif other.dir == 'E' then
              self.x = ENTRY_WEST_X
              self.y = ENTRY_WEST_Y
            elseif other.dir == 'S' then
              self.x = ENTRY_NORTH_X
              self.y = ENTRY_NORTH_Y
            elseif other.dir == 'W' then
              self.x = ENTRY_EAST_X
              self.y = ENTRY_EAST_Y
            end
          --if the player has the key, open the locked door
          --don't open any doors that lead to none
          elseif self.hasKey == true then
            if other.connectsTo ~= 'none' then
              other.isLocked = false
              gSounds['doorOpen']:play()
              self.hasKey = false
            end
          else
            self.gotoRoom = 'none'
          end
        --if the player collides with the heart object, heal the player
        elseif other.type == 'GameObject' then 
          if other.gameObjectType == 'heart' then
            if self.health < 5 then
              self:damage(-2)
              self.isInvulnerable = false
              other.isTrigger = true
              gSounds['heal']:play()
            else
              self.health = 6
              other.isTrigger = true
              gSounds['heal']:play()
            end
          --if the player collides with the key, set haskey to true
          elseif other.gameObjectType == 'key' then
            --allows the item to be picked up
            other.isTrigger = true
            self.hasKey = true
            gSounds['key']:play()
          --if the player collides with the phantome, istrigger is true
          --in the phantome object transition to the winstate
          elseif other.gameObjectType == 'phantome' then
            other.isTrigger = true
          end
        --enemies cause damage to the player
        --player, entity collision
        elseif other.type == 'Entity' then
          gSounds['hitPlayer']:play()
          self:damage(1)
        end
      end
    --enemies cause damage to the player 
    --entity, player collision
    elseif self.type == 'Entity' then
      for i = 1, numOfCollisions do 
      local other = collisionTable[i].other
        if other.type == 'Entity' and other.entityType == 'player' then
          gSounds['hitPlayer']:play()
          other:damage(1)
        end
      end
    end
  end
  
  function Entity:enemyAI(dt)
    self.stateMachine:enemyAI(dt)
  end
  
  function Entity:damage(dmg)
    --entity damage function, damage is set in the argument
    if not self.isInvulnerable then
      self.health = self.health - dmg
      self.isInvulnerable = true
    elseif dmg < 0 then
      self.health = self.health - dmg
    end
  end
  
  
  function Entity:changeState(name)
    --call the statemachine's change state function
    self.stateMachine:change(name)
  end

  
  function Entity:render()
    --blink the entity's sprites when they are invincible
    if self.isInvulnerable and self.blinkTimer > 0.15 then
      if self.blinkTimer > 0.3 then
        self.blinkTimer = 0
      end
    else
      --call the statemachine's render function
      self.stateMachine:render()
    end

  end