--[[
  Title: The Phantome
  Author: Laura Clarke
  Email: 09.l.clarke.09@gmail.com
  Edx: __L-Clarke__
  GitHub: L-C-game
  Explanation:
  The Entity idle state
  ]]
  
  EntityIdleState = Class{__includes = BaseState}
  
  function EntityIdleState:init(entity)
    self.entity = entity
    
    self.idleTime = 0
  end
  
  --AI for the enemies
  function EntityIdleState:enemyAI(dt)
    if self.idleTime > 3 then
      self.entity:changeState('walk')
      self.idleTime = 0
    end
    self.idleTime = self.idleTime + dt
  end
  
  function EntityIdleState:update(dt)
    
  end
  
  function EntityIdleState:render()
    self.entity.animationIdle:gotoFrame(self.entity.idleFrame)
    self.entity.animationIdle:draw(self.entity.image, self.entity.x, self.entity.y)
  end
  
  