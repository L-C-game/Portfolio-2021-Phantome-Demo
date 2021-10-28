--[[
  Title: The Phantome
  Author: Laura Clarke
  Email: 09.l.clarke.09@gmail.com
  Edx: __L-Clarke__
  GitHub: L-C-game
  Explanation:
  The story state
  ]]
  
StoryState = Class{__includes = BaseState}

function StoryState:init()
  
end

function StoryState:enter(params)

end

function StoryState:update(dt)
    
    --Toggle highlighted option if we press s or the down arrow key
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
      gSounds['confirm']:play()
      --push the playstate
      gSounds['title']:stop()
      gStateStack:pop()
      gStateStack:push(PlayState())
    end
    
    -- Allow the player to quit easily at any time
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function StoryState:render()
  --Set the background colour to black
  love.graphics.setBackgroundColor( 0, 0, 0, 1)
  
  --Display the title
  love.graphics.setFont(gFonts['story'])
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.printf(' Deep in the forest lies the village of Verdigris,\n The denizens of the village, the Weald Sprites,\n lived in harmony...\n Until a tenebrous miasma descended upon the forest,\n Such a poweful curse can only be undone using it\'s origin.\n The arcane forbidden text...\n The Phantome.', 2, VIRTUAL_HEIGHT / 2 - 60, VIRTUAL_WIDTH, 'center')  
end