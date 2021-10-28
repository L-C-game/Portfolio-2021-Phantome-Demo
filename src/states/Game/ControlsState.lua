--[[
  Title: The Phantome
  Author: Laura Clarke
  Email: 09.l.clarke.09@gmail.com
  Edx: __L-Clarke__
  GitHub: L-C-game
  Explanation:
  The control state
  ]]
  
ControlsState = Class{__includes = BaseState}

function ControlsState:init()
  
end

function ControlsState:enter(params)
  
end

function ControlsState:update(dt)
  --backspace takes us back to the title 
    if love.keyboard.wasPressed('backspace') then
      gStateStack:pop()
      gStateStack:push(TitleState())
    end
  -- Allow the player to quit easily at any time
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function ControlsState:render()
  --Set the background colour to black
  love.graphics.setBackgroundColor( 0, 0, 0, 1)
  
  --Display the title
  love.graphics.setFont(gFonts['title-small'])
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.printf('Controls', 2, VIRTUAL_HEIGHT / 2 - 60, VIRTUAL_WIDTH, 'center')
  love.graphics.setFont(gFonts['menu'])
  love.graphics.printf('W,A,S,D or arrow keys to move\n\nReturn to select\n\nSpacebar to attack\n\nEscape to quit the game\n\nBackspace return to title', 2, VIRTUAL_HEIGHT / 2 - 30, VIRTUAL_WIDTH, 'left')
end
