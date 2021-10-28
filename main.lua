--[[
  Title: The Phantome
  Author: Laura Clarke
  Email: 09.l.clarke.09@gmail.com
  Edx: __L-Clarke__
  GitHub: L-C-game
  Explanation:
  Setting up the state stack
  ]]
  
  require 'src/Dependencies'
  
  function love.load()
    --Setting the game title
    love.window.setTitle('The Phantome')
    --Setting the filtering to give a crisp pixellated appearance
    love.graphics.setDefaultFilter('nearest', 'nearest')
    --seeding the random number generator so that it may be used throughout the project
    math.randomseed(os.time())
    
    
    --Setting the size of the screen,
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

    --The state stack, this allows states to run over the play state for example
    gStateStack = StateStack()
    gStateStack:push(TitleState())
    --Table to stores key presses
    love.keyboard.keysPressed = {}
end

--makes the window resizable
function love.resize(w, h)
    push:resize(w, h)
end

--allows the player to exit the game at any time using escape
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    love.keyboard.keysPressed[key] = true
end


function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

--updates the timer and statestack, clears keys pressed table
function love.update(dt)
    Timer.update(dt)
    gStateStack:update(dt)

    love.keyboard.keysPressed = {}
end

--drawing function, renders the members of the statestack
function love.draw()
    push:start()
    gStateStack:render()
    push:finish()
end