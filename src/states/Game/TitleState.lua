--[[
  Title: The Phantome
  Author: Laura Clarke
  Email: 09.l.clarke.09@gmail.com
  Edx: __L-Clarke__
  GitHub: L-C-game
  Explanation:
  The Title state
  ]]
  
TitleState = Class{__includes = BaseState}

function TitleState:init()
  --Top menu option position
  top = VIRTUAL_HEIGHT / 2 + 10
  --Middle menu option position
  middle = VIRTUAL_HEIGHT / 2 + 30
  --Bottom menu option position
  bottom = VIRTUAL_HEIGHT / 2 + 50
  
  --Cursor position
  cursorY = VIRTUAL_HEIGHT / 2 + 10
  --simplifying the code
  self.cursor = gAnim8['cursor']
  --Setting the cursor frame 
  self.cursor:gotoFrame(1)
end

function TitleState:enter(params)

end

function TitleState:update(dt)
    --Toggle highlighted option if we press s or the down arrow key
    if love.keyboard.wasPressed('down') or love.keyboard.wasPressed('s') then
      if cursorY < top + 40 then
        cursorY = cursorY + 20
      --allow the player to loop back  around through the menu for ease of use
      elseif cursorY > top then
        cursorY = top
      end
        gSounds['select']:play()
    end
    --Toggle highlighted option if we press w or the up arrow key
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('w') then
      if cursorY > top then
        cursorY = cursorY - 20
      --allow the player to loop back  around through the menu for ease of use
      elseif cursorY < top + 1 then
        cursorY = bottom
      end
        gSounds['select']:play()
    end
    
    --Select an option using enter or return
    if (love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return')) and cursorY == top then
      gSounds['confirm']:play()
      gStateStack:pop()
      gStateStack:push(StoryState())
    --push the controls menu state
    elseif (love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return')) and cursorY == middle then
      gSounds['confirm']:play()
      gStateStack:pop()
      gStateStack:push(ControlsState())
    --
    elseif (love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return')) and cursorY == bottom then
      gSounds['confirm']:play()
      love.event.quit()
    end
    
    -- Allow the player to quit easily at any time
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

  --Title menu music 
    gSounds['title']:setLooping(true)
    gSounds['title']:play()
    
end

function TitleState:render()
  --Set the background colour to black
  love.graphics.setBackgroundColor( 0, 0, 0, 1)
  
  --Display the title
  love.graphics.setFont(gFonts['title'])
  love.graphics.setColor(0, 171/255, 132/255, 1)
  love.graphics.printf('The Phantome', 2, VIRTUAL_HEIGHT / 2 - 45, VIRTUAL_WIDTH, 'center')
  --Display the menu options
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.setFont(gFonts['menu'])
  love.graphics.printf('Play', 2, top, VIRTUAL_WIDTH, 'center')
  love.graphics.printf('Controls', 2, middle, VIRTUAL_WIDTH, 'center')
  love.graphics.printf('Quit', 2, bottom, VIRTUAL_WIDTH, 'center')
  
  --Draw the cursor
  self.cursor:draw(gTextures['cursor'], VIRTUAL_WIDTH / 2 - 50, cursorY)
  
end