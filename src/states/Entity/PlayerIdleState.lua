--[[
  Title: The Phantome
  Author: Laura Clarke
  Email: 09.l.clarke.09@gmail.com
  Edx: __L-Clarke__
  GitHub: L-C-game
  Explanation:
  The Player idle state
  ]]
  
  PlayerIdleState = Class{__includes = EntityIdleState}
  
  function PlayerIdleState:enter(params)
    
  end
  
  function PlayerIdleState:update(dt)
    EntityIdleState.update(self, dt)

    --Change state to walking on player movement input
    if love.keyboard.isDown('left') or love.keyboard.isDown('a') or 
      love.keyboard.isDown('right') or love.keyboard.isDown('d') or
      love.keyboard.isDown('up') or love.keyboard.isDown('w') or 
      love.keyboard.isDown('down') or love.keyboard.isDown('s') then
        self.entity:changeState('walk')
    --change state to attack
    elseif love.keyboard.isDown('space') then
        gSounds['swordSwipe']:play()
        self.entity:changeState('attack')
    end
    
  end