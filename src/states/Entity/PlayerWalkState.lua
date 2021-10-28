--[[
  Title: The Phantome
  Author: Laura Clarke
  Email: 09.l.clarke.09@gmail.com
  Edx: __L-Clarke__
  GitHub: L-C-game
  Explanation:
  The Player walk state
  ]]
  
  PlayerWalkState = Class{__includes = EntityMoveState}
  
  function PlayerWalkState:init(player, bumpWorld)
      self.bumpWorld = bumpWorld
      self.entity = player
    
  end
  
  function PlayerWalkState:update(dt)
    --set the direction of the player based on the user input
    if love.keyboard.isDown('left') or love.keyboard.isDown('a') then
        self.entity.direction = 'L'
    elseif love.keyboard.isDown('right') or love.keyboard.isDown('d') then
        self.entity.direction = 'R'
    elseif love.keyboard.isDown('up') or love.keyboard.isDown('w') then
        self.entity.direction = 'U'
    elseif love.keyboard.isDown('down') or love.keyboard.isDown('s') then
        self.entity.direction = 'D'
    --change to attack if the player presses space
    elseif love.keyboard.isDown('space') then
        gSounds['swordSwipe']:play()
        self.entity:changeState('attack')
    --otherwise change state to idle
    else
        self.entity:changeState('idle')
    end
    
    EntityMoveState.update(self, dt)
    
  end