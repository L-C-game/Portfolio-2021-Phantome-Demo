--[[
  Title: The Phantome
  Author: Laura Clarke
  Email: 09.l.clarke.09@gmail.com
  Edx: __L-Clarke__
  GitHub: L-C-game
  Explanation:
  The Playstate
  ]]
  
  PlayState = Class{__includes = BaseState}
  
  function PlayState:init()
    --Initialise bump world
    self.bumpWorld = bump.newWorld()
    
    --Initialise player: 
    self.player = Player(ENTITY_DEFS['player']) 
    
    --Create a table to hold the different rooms
    self.rooms = {}
    
    --Populate the table with the room objects with their respective definitions
    for k, room_def in pairs(ROOM_DEFS) do
      table.insert(self.rooms, Room(room_def, self.bumpWorld))
    end
    
    --Set current room:
    self:setRoom('entrance')
    
    --Call collision setup methods
    self.player:setUpCollision(self.bumpWorld)
    
    self.currentRoom:setUpCollision(self.bumpWorld)
    
    --Hearts UI positions
    heartX = {
      16,
      32,
      48,
    }
    
    --hearts 
    self.heartAnims = {}
    for i = 1, 3 do
      local heartAnim = gAnim8['hearts']
      table.insert(self.heartAnims, heartAnim)
    end
    
  
    --Player StateMachine
    self.player.stateMachine = StateMachine {
      ['walk'] = function() return PlayerWalkState(self.player, self.bumpWorld) end,
      ['idle'] = function() return PlayerIdleState(self.player) end,
      ['attack'] = function() return PlayerAttackState(self.player, self.bumpWorld) end,
    }
    --Be idle initially
    self.player:changeState('idle')
    
  end
  
  function PlayState:setRoom(gotoRoom)
      --Set current room:
    for k, testRoom in pairs(self.rooms) do
      if testRoom.name == gotoRoom then
        self.currentRoom = testRoom
      end
    end
  end
  
  function PlayState:enter()
    
  end
  
  function PlayState:update(dt)
    --Set the game audio to loop
    love.audio.setVolume( 0.40 )
    gSounds['game']:setLooping(true)
    gSounds['game']:play()
    
    --allow the player to quit the game easily at any time
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
    
    --make sure the player updates
    self.player:update(dt)
    
    --make sure the room updates
    self.currentRoom:update(dt)

    --Set the active room based on if the player and door collide, based on the string passed in gotoRoom
    if self.player.gotoRoom ~= 'none' then
        --get rid of collision for this room
        self.currentRoom:destroyCollision(self.bumpWorld)
        self.player:destroyCollision(self.bumpWorld)
        -- set new room, based on direction
        self:setRoom(self.player.gotoRoom)
        self.player.gotoRoom = 'none'
        -- set up collision for new room
        self.currentRoom:setUpCollision(self.bumpWorld)
        self.player:setUpCollision(self.bumpWorld)
    end
        
    --transition to the gameover state when the player's health reaches 0  
    if self.player.health == 0  then
      gSounds['game']:stop()
      gStateStack:pop()
      gStateStack:push(GameOverState())
    end
    
  end
  
  function PlayState:render()
    --Render the current room
    self.currentRoom:render()
    --Render the player object
    self.player:render()
    
      --render UI: Hearts
      local currentHealth = self.player.health
      local heartFrame = 1
      
      --Display 3 hearts, each heart is worth 2 health 
      --frame 1 = full heart, frame 2 = half heart, frame  = empty heart
    for k, heart in pairs(self.heartAnims) do
      --Whole heart
      if currentHealth > (1 + (2 * (k - 1))) then
        --heartFrame = 1
        heart:gotoFrame(1)
      --Half heart 
      elseif currentHealth > (2 * (k - 1)) then
        --heartFrame = 2
        heart:gotoFrame(2)
      --Empty heart
      else 
        --heartFrame = 3
        heart:gotoFrame(3)
        --if all 3 hearts = frame 3 then push Game over state
      end
      --love.graphics.draw(gTextures['hearts'], gFrames['hearts'][heartFrame], heartX[k-1], HEART_Y)
      heart:draw(gTextures['hearts'], heartX[k-1], HEART_Y)
    end
    
    if self.player.hasKey then
      --render key for inventory
      gAnim8['key']:gotoFrame(2)
      gAnim8['key']:draw(gTextures['key'], 192, 0)
    end
    
  end

  