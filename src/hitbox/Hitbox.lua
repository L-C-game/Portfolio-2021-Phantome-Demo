--[[
  Title: The Phantome
  Author: Laura Clarke
  Email: 09.l.clarke.09@gmail.com
  Edx: __L-Clarke__
  GitHub: L-C-game
  Explanation:
  The attack/hitbox class
  ]]
  
  Hitbox = Class{}
  
  function Hitbox:init(def)
    self.type = 'Hitbox'
    self.hitboxType = def.hitboxType
    self.x = def.x
    self.y = def.y
    self.isActive = false
  end
  
  function Hitbox:setUpCollision(bumpWorld, x, y, width, height)
    self.x = x
    self.y = y
    bumpWorld:add(self, x, y, width, height)
  end
  
  function Hitbox:filter(other)
    --hitbox specific collision filters
    if self.hitboxType == 'sword' then
      if other.type == 'Entity' and other.entityType == 'enemy' then
        return 'cross'
      else
        return 'slide'
      end
    else
      return 'slide'
    end
  end
  
  function Hitbox:checkCollisions(bumpWorld) 
    --decrement the enemies health when the enemy and sword hitbox collide
    local actualX, actualY, collisionTable, numOfCollisions = bumpWorld:check(self, self.x, self.y, self.filter)
    if self.hitboxType == 'sword' then
      for i = 1, numOfCollisions do 
        local other = collisionTable[i].other
        if other.type == 'Entity' and other.entityType == 'enemy' then
          gSounds['hitEnemy']:play()
          other:damage(1)
        end
      end
    end
  end
  
  function Hitbox:destroyCollision(bumpWorld)
    bumpWorld:remove(self)
  end
  
  function Hitbox:update(dt)
    
  end
  
  function Hitbox:render()
    
  end