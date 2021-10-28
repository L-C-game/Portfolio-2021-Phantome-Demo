--[[
  Title: The Phantome
  Author: Laura Clarke
  Email: 09.l.clarke.09@gmail.com
  Edx: __L-Clarke__
  GitHub: L-C-game
  Explanation:
  Relevant includes
  ]]
  
--Library includes  
Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
anim8 = require 'lib/anim8'
bump = require 'lib/bump'
Timer = require 'lib/knife.timer'

--Require folders src
require 'src/constants'
require 'src/util'
require 'src/StateMachine'

--Textures
gTextures = {
  ['cursor'] = love.graphics.newImage('graphics/cursor.png'),
  ['tiles'] = love.graphics.newImage('graphics/tiles.png'),
  ['hearts'] = love.graphics.newImage('graphics/hearts.png'),
  ['doors'] = love.graphics.newImage('graphics/doors.png'),
  ['chest'] = love.graphics.newImage('graphics/chest.png'),
  ['key'] = love.graphics.newImage('graphics/bossKey.png'),
  ['phantome'] = love.graphics.newImage('graphics/phantome.png'),
  ['playerWalkImage'] = love.graphics.newImage('graphics/playerWalk.png'),
  ['skellyWalkImage'] = love.graphics.newImage('graphics/skellyWalk.png'),
  ['slimeMoveImage'] = love.graphics.newImage('graphics/slimeWalk.png'),
  ['playerAttRL'] = love.graphics.newImage('graphics/playerAttackRL.png'),
  ['playerAttDU'] = love.graphics.newImage('graphics/playerAttackUD.png'),
  }

--animation grid
gAnim8Grid = {
  ['cursorGrid'] = anim8.newGrid(16, 16, gTextures['cursor']:getWidth(), gTextures['cursor']:getHeight()),
  ['heartsGrid'] = anim8.newGrid(16, 16, gTextures['hearts']:getWidth(), gTextures['hearts']:getHeight()),
  ['chestGrid'] = anim8.newGrid(16, 16, gTextures['chest']:getWidth(), gTextures['chest']:getHeight()),
  ['keyGrid'] = anim8.newGrid(16, 16, gTextures['key']:getWidth(), gTextures['key']:getHeight()),
  ['phantomeGrid'] = anim8.newGrid(16, 16, gTextures['phantome']:getWidth(), gTextures['phantome']:getHeight()),
  ['playerWalkGrid'] = anim8.newGrid(16, 16, gTextures['playerWalkImage']:getWidth(), gTextures['playerWalkImage']:getHeight()),
  ['skellyWalkGrid'] = anim8.newGrid(16, 16, gTextures['skellyWalkImage']:getWidth(), gTextures['skellyWalkImage']:getHeight()),
  ['slimeMoveGrid'] = anim8.newGrid(16, 16, gTextures['slimeMoveImage']:getWidth(), gTextures['slimeMoveImage']:getHeight()),
  ['playerAttRLGrid'] = anim8.newGrid(18, 18, gTextures['playerAttRL']:getWidth(), gTextures['playerAttRL']:getHeight()),
  ['playerAttDUGrid'] = anim8.newGrid(16, 22, gTextures['playerAttDU']:getWidth(), gTextures['playerAttDU']:getHeight()),
  ['doorGrid'] = anim8.newGrid(16, 16, gTextures['doors']:getWidth(), gTextures['doors']:getHeight()),
  }

--frames
gFrames = {
  --Static frames
  ['tiles'] = GenerateQuads(gTextures['tiles'], 16, 16),
  --['playerDebug'] = GenerateQuads(gTextures['playerWalkImage'], 16, 16),
  --Chest animation
  ['chestFrames'] = gAnim8Grid['chestGrid']:getFrames('1-3', 1),
  --Key animation
  ['keyFrames'] = gAnim8Grid['keyGrid']:getFrames('1-2', 1),
  --Phantome animation
  ['phantomeFrames'] = gAnim8Grid['phantomeGrid']:getFrames('1-4', 1),
  --Door animation
  ['doorFrames'] = gAnim8Grid['doorGrid']:getFrames('1-6',1),
  --Cursor animation
  ['cursorFrames'] = gAnim8Grid['cursorGrid']:getFrames('1-2',1),
  --Heart animation
  ['heartFrames'] = gAnim8Grid['heartsGrid']:getFrames('1-3',1),
  --Player walk animations
  ['playerWalkFramesDown'] = gAnim8Grid['playerWalkGrid']:getFrames('1-4', 1),
  ['playerWalkFramesUp'] = gAnim8Grid['playerWalkGrid']:getFrames('5-8', 1),
  ['playerWalkFramesR'] = gAnim8Grid['playerWalkGrid']:getFrames('1-4', 2),
  ['playerWalkFramesL'] = gAnim8Grid['playerWalkGrid']:getFrames('5-8', 2),
  --Skeleton walk animations
  ['skellyWalkFramesDown'] = gAnim8Grid['skellyWalkGrid']:getFrames('1-4', 1),
  ['skellyWalkFramesUp'] = gAnim8Grid['skellyWalkGrid']:getFrames('5-8', 1),
  ['skellyWalkFramesR'] = gAnim8Grid['skellyWalkGrid']:getFrames('1-4', 2),
  ['skellyWalkFramesL'] = gAnim8Grid['skellyWalkGrid']:getFrames('5-8', 2),
  --Slime move animations
  ['slimeMoveFrames'] = gAnim8Grid['slimeMoveGrid']:getFrames('1-3', 1),
  --player attack animation
  ['playerAttFramesD'] = gAnim8Grid['playerAttDUGrid']:getFrames('1-3', 1),
  ['playerAttFramesU'] = gAnim8Grid['playerAttDUGrid']:getFrames('4-6', 1),
  ['playerAttFramesR'] = gAnim8Grid['playerAttRLGrid']:getFrames('1-3', 1),
  ['playerAttFramesL'] = gAnim8Grid['playerAttRLGrid']:getFrames('4-6', 1),
  }

--animations
gAnim8 = {
  ['cursor'] = anim8.newAnimation(gFrames['cursorFrames'], 0.5),
  ['doors'] = anim8.newAnimation(gFrames['doorFrames'], 1),
  ['hearts'] = anim8.newAnimation(gFrames['heartFrames'], 1),
  ['chest'] = anim8.newAnimation(gFrames['chestFrames'], 0.05, 'pauseAtEnd'),
  ['key'] = anim8.newAnimation(gFrames['keyFrames'], 1),
  ['phantome'] = anim8.newAnimation(gFrames['phantomeFrames'], 0.5),
  --Player Walk animation
  ['playerWalkUp'] = anim8.newAnimation(gFrames['playerWalkFramesUp'], 0.1),
  ['playerWalkDown'] = anim8.newAnimation(gFrames['playerWalkFramesDown'], 0.1),
  ['playerWalkRight'] = anim8.newAnimation(gFrames['playerWalkFramesR'], 0.1),
  ['playerWalkLeft'] = anim8.newAnimation(gFrames['playerWalkFramesL'], 0.1),
  --Skeleton Walk animation
  ['skellyWalkUp'] = anim8.newAnimation(gFrames['skellyWalkFramesUp'], 0.1),
  ['skellyWalkDown'] = anim8.newAnimation(gFrames['skellyWalkFramesDown'], 0.1),
  ['skellyWalkRight'] = anim8.newAnimation(gFrames['skellyWalkFramesR'], 0.1),
  ['skellyWalkLeft'] = anim8.newAnimation(gFrames['skellyWalkFramesL'], 0.1),
  --slime move animation
  ['slimeMove'] = anim8.newAnimation(gFrames['slimeMoveFrames'], 0.2),
  --player attack animation
  ['playerAttU'] = anim8.newAnimation(gFrames['playerAttFramesU'], {0.15, 0.15, 0.2}),
  ['playerAttD'] = anim8.newAnimation(gFrames['playerAttFramesD'], {0.15, 0.15, 0.2}),
  ['playerAttR'] = anim8.newAnimation(gFrames['playerAttFramesR'], {0.15, 0.15, 0.2}),
  ['playerAttL'] = anim8.newAnimation(gFrames['playerAttFramesL'], {0.15, 0.15, 0.2}),
  }

--fonts used in the game
gFonts = {
  ['title'] = love.graphics.newFont('fonts/alagard.ttf', 32),
  ['title-small'] = love.graphics.newFont('fonts/alagard.ttf', 16),
  ['menu'] = love.graphics.newFont('fonts/earthbound-beginnings.ttf', 8),
  ['story'] = love.graphics.newFont('fonts/zeldadxt.ttf', 11),
  }

--sound files used in the game
gSounds = {
  ['title'] = love.audio.newSource('sounds/Epic1x.wav', 'stream'),
  ['game'] = love.audio.newSource('sounds/Dark Rooms and Scary Things - isaiah658.ogg', 'stream'),
  ['select'] = love.audio.newSource('sounds/select.wav', 'static'),
  ['confirm'] = love.audio.newSource('sounds/confirm.wav', 'static'),
  ['game-over'] = love.audio.newSource('sounds/TheForest.wav', 'stream'),
  ['hitEnemy'] = love.audio.newSource('sounds/hitEnemy.wav', 'static'),
  ['hitPlayer'] = love.audio.newSource('sounds/hitPlayer.wav', 'static'),
  ['swordSwipe'] = love.audio.newSource('sounds/swordSwipe.wav', 'static'),
  ['heal'] = love.audio.newSource('sounds/heal.wav', 'static'),
  ['key'] = love.audio.newSource('sounds/key.wav', 'static'),
  ['doorOpen'] = love.audio.newSource('sounds/doorOpen.wav', 'static'),
  ['you-win'] = love.audio.newSource('sounds/Adventure.mp3', 'stream'),
  }

--Require folders world
require 'src/world/Room'
require 'src/world/room_defs'
require 'src/world/Door'
require 'src/world/wall_defs'
require 'src/world/Wall'

--Require folders entity
require 'src/entity/Entity'
require 'src/entity/entity_defs'
require 'src/entity/Player'

--Require folders hitbox
require 'src/hitbox/Hitbox'
require 'src/hitbox/hitbox_defs'

--Require folders gameobjects
require 'src/gameObjects/GameObject'
require 'src/gameObjects/gameObject_defs'
require 'src/gameObjects/Chest'
require 'src/gameObjects/Key'
require 'src/gameObjects/Heart'
require 'src/gameObjects/Phantome'

--Require folders states
require 'src/states/BaseState'
require 'src/states/StateStack'

--Game states
require 'src/states/Game/TitleState'
require 'src/states/Game/StoryState'
require 'src/states/Game/ControlsState'
require 'src/states/Game/PlayState'
require 'src/states/Game/GameOverState'
require 'src/states/Game/WinState'

--Entity states
require 'src/states/Entity/EntityIdleState'
require 'src/states/Entity/EntityMoveState'
require 'src/states/Entity/PlayerIdleState'
require 'src/states/Entity/PlayerWalkState'
require 'src/states/Entity/PlayerAttackState'

