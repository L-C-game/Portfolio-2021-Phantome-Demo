--[[
  Title: The Phantome
  Author: Laura Clarke
  Email: 09.l.clarke.09@gmail.com
  Edx: __L-Clarke__
  GitHub: L-C-game
  Explanation:
  The Game over state
  ]]
  
  GameOverState = Class{__includes = BaseState}
  
  function GameOverState:init()
    upper = VIRTUAL_HEIGHT / 2 + 20
    lower = VIRTUAL_HEIGHT / 2 + 40
    
    --Cursor position
    cursorY = VIRTUAL_HEIGHT / 2 + 20
    love.audio.setVolume( 0.40 )
    gSounds['game-over']:play()
  end
  
  function GameOverState:update(dt)
    --Toggle highlighted option if we press s or the down arrow key
    if love.keyboard.wasPressed('down') or love.keyboard.wasPressed('s') then
      if cursorY < upper + 20 then
        cursorY = cursorY + 20
      --allow the player to loop back  around through the menu for ease of use
      elseif cursorY > upper then
        cursorY = upper
      end
        gSounds['select']:play()
    end
    --Toggle highlighted option if we press w or the up arrow key
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('w') then
      if cursorY > upper then
        cursorY = cursorY - 20
      --allow the player to loop back  around through the menu for ease of use
      elseif cursorY < upper + 1 then
        cursorY = lower
      end
        gSounds['select']:play()
    end
    
    --Select an option using enter or return
    if (love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return')) and cursorY == upper then
      gSounds['confirm']:play()
      gSounds['game-over']:stop()
      gStateStack:pop()
      gStateStack:push(TitleState())
    elseif (love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return')) and cursorY == lower then
      gSounds['confirm']:play()
      love.event.quit()
    end
    -- Allow the player to quit easily at any time
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
  end
  
  function GameOverState:render()
    --Set the background colour to black
    love.graphics.setBackgroundColor( 0, 0, 0, 1)
    
    --Display the title
    love.graphics.setFont(gFonts['title'])
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.printf('Game Over', 2, VIRTUAL_HEIGHT / 2 - 45, VIRTUAL_WIDTH, 'center')
    

    
    --Display the menu options
    love.graphics.setFont(gFonts['menu'])
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf('Try again?', 2, upper, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Quit', 2, lower, VIRTUAL_WIDTH, 'center')
    
    --Draw the cursor
    gAnim8['cursor']:draw(gTextures['cursor'], VIRTUAL_WIDTH / 2 - 60, cursorY)
  end
  