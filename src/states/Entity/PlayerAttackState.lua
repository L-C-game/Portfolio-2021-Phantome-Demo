--[[
  Title: The Phantome
  Author: Laura Clarke
  Email: 09.l.clarke.09@gmail.com
  Edx: __L-Clarke__
  GitHub: L-C-game
  Explanation:
  The Player attack state
  ]]
  
  PlayerAttackState = Class{__includes = EntityIdleState}
  
  function PlayerAttackState:init(player, bumpWorld)
    self.entity = player
    self.animateTimer = 0
    self.bumpWorld = bumpWorld
  end
  
  function PlayerAttackState:enter()
    gSounds['swordSwipe']:play()
    
    --The hitbox size of the sword depends on the orientation of the player
    self.entity.hitbox.isActive = true
    local x, y, width, height
    if self.entity.direction == 'L' then
      x = self.entity.x - 8
      y = self.entity.y + 6
      width = 8
      height = 4
    elseif self.entity.direction == 'R' then
      x = self.entity.x + 16
      y = self.entity.y + 6
      width = 8
      height = 4
    elseif self.entity.direction == 'U' then
      x = self.entity.x + 6
      y = self.entity.y - 8
      width = 4
      height = 8
    elseif self.entity.direction == 'D' then
      x = self.entity.x + 6
      y = self.entity.y + 16
      width = 8
      height = 4
    end
    self.entity.hitbox:setUpCollision(self.bumpWorld, x, y, width, height)
  end
  
  function PlayerAttackState:update(dt)
    self.entity.hitbox:checkCollisions(self.bumpWorld)
    --update the animations depending on the orientation of the player
    if self.entity.direction == 'L' then
      gAnim8['playerAttL']:update(dt)
    elseif self.entity.direction == 'R' then
      gAnim8['playerAttR']:update(dt)
    elseif self.entity.direction == 'U' then
      gAnim8['playerAttU']:update(dt)
    elseif self.entity.direction == 'D' then
      gAnim8['playerAttD']:update(dt)
    end
    
    --lock into the attack for the whole animation
    if self.animateTimer > 0.5 then
      if love.keyboard.isDown('space') then
        gSounds['swordSwipe']:play()
        self.animateTimer = 0
      else 
        self.animateTimer = 0
        self.entity.hitbox.isActive = false
        self.entity.hitbox:destroyCollision(self.bumpWorld)
        self.entity:changeState('idle')
      end
    else
      self.animateTimer = self.animateTimer + dt
    end
  end
  
  function PlayerAttackState:render()
    --set up the animations with offset
    if self.entity.direction == 'L' then
      gAnim8['playerAttL']:draw(gTextures['playerAttRL'], self.entity.x, self.entity.y)
    elseif self.entity.direction == 'R' then
      gAnim8['playerAttR']:draw(gTextures['playerAttRL'], self.entity.x, self.entity.y)
    elseif self.entity.direction == 'U' then
      gAnim8['playerAttU']:draw(gTextures['playerAttDU'], self.entity.x, self.entity.y, 0, 1, 1, 0, 3)
    elseif self.entity.direction == 'D' then
      gAnim8['playerAttD']:draw(gTextures['playerAttDU'], self.entity.x, self.entity.y, 0, 1, 1, 0, 3)
    end
  end