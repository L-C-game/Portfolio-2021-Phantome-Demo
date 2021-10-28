--[[
  Title: The Phantome
  Author: Laura Clarke
  Email: 09.l.clarke.09@gmail.com
  Edx: __L-Clarke__
  GitHub: L-C-game
  Explanation:
  The Entity move state
  ]]
  
  EntityMoveState = Class{__includes = BaseState}
  
  function EntityMoveState:init(entity, bumpWorld)
    self.bumpWorld = bumpWorld
    self.entity = entity
    
    self.moveTimer = 0
    
  end
  
  --AI for the enemies
  function EntityMoveState:enemyAI(dt)
    local randDirectionIndex = math.random(1, 4)
    --enemy AI, walk or idle randomly
    if self.moveTimer == 0 then
      self.entity.direction = self.entity.randDirection[randDirectionIndex]
    elseif self.moveTimer > 3 then
      if math.random(2) > 1 then
        self.entity.direction = self.entity.randDirection[randDirectionIndex]
        self.moveTimer = 0
      else
        self.moveTimer = 0
        self.entity:changeState('idle')
      end
    end
    self.moveTimer = self.moveTimer + dt
    
  end
      
  
  function EntityMoveState:update(dt)
    
    local goalX
    local goalY
    --Handling of entity movement, taking into account collision and updating the relevant animations
    if self.entity.direction == 'L' then
      --Setting up the 'goal' x and y variables for bump collision
      --x - 1 as we are moving left
      goalX = self.entity.x - 1
      goalY = self.entity.y

      --update the moving left animation
      self.entity.animationMoveL:update(dt)
      
    elseif self.entity.direction == 'R' then
      --Setting up the 'goal' x and y variables for bump collision
      --x + 1 as we are moving right
      goalX = self.entity.x + 1
      goalY = self.entity.y
      
      --update the moving right animation
      self.entity.animationMoveR:update(dt)
      
    elseif self.entity.direction == 'U' then
      --Setting up the 'goal' x and y variables for bump collision
      --y - 1 as we are moving upwards
      goalY = self.entity.y - 1
      goalX = self.entity.x
      
      --update the moving upwards animation
      self.entity.animationMoveU:update(dt)
      
    elseif self.entity.direction == 'D' then
      --Setting up the 'goal' x and y variables for bump collision
      --y + 1 as we are moving downwards
      goalY = self.entity.y + 1
      goalX = self.entity.x
      
      --update the moving downwards animation
      self.entity.animationMoveD:update(dt)
    end
    
    self.entity:move(self.bumpWorld, goalX, goalY) 
    
  end
  
  function EntityMoveState:render()
    
    --Set the relevant animation depending on the direction of movement
    if self.entity.direction == 'L' then
      self.entity.animationMoveL:draw(self.entity.image, self.entity.x, self.entity.y)
    elseif self.entity.direction == 'R' then
      self.entity.animationMoveR:draw(self.entity.image, self.entity.x, self.entity.y)
    elseif self.entity.direction == 'U' then
      self.entity.animationMoveU:draw(self.entity.image, self.entity.x, self.entity.y)  
    elseif self.entity.direction == 'D' then
      self.entity.animationMoveD:draw(self.entity.image, self.entity.x, self.entity.y)
    end
    
  end
  