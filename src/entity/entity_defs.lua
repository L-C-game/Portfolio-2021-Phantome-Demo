--[[
  Title: The Phantome
  Author: Laura Clarke
  Email: 09.l.clarke.09@gmail.com
  Edx: __L-Clarke__
  GitHub: L-C-game
  Explanation:
  The Entity defs
  ]]
  
  ENTITY_DEFS = {
    ['player'] = {
      --entity type
      entityType = 'player',
      
      --Player dimensions
      width = 16,
      height = 16,
      
      --Player position
      x = ENTRY_SOUTH_X,
      y = ENTRY_SOUTH_Y,
      
      --Player image 
      image = gTextures['playerWalkImage'],
      
      --Player health
      health = 6,
      
      --Player animations, walking
      animation = {
        ['moveDown'] = gAnim8['playerWalkDown'],
        ['moveUp'] = gAnim8['playerWalkUp'],
        ['moveRight'] = gAnim8['playerWalkRight'],
        ['moveLeft'] = gAnim8['playerWalkLeft'],
      },
      
      collisionBox = {
        ['width'] = 10,
        ['height'] = 14
      },
  
      idleFrame = 2,
    },
    ['skelly'] = {
      entityType = 'enemy',
      width = 16,
      height = 16,
      x = 32,
      y = 32,
      image = gTextures['skellyWalkImage'],
      health = 4,
      animation = {
        ['moveDown'] = gAnim8['skellyWalkDown'],
        ['moveUp'] = gAnim8['skellyWalkUp'],
        ['moveRight'] = gAnim8['skellyWalkRight'],
        ['moveLeft'] = gAnim8['skellyWalkLeft'],
      },
      collisionBox = {
        ['width'] = 6,
        ['height'] = 14
      },
      idleFrame = 2,
    },
    ['slime'] = {
      entityType = 'enemy',
      width = 16,
      height = 16,
      x = 176,
      y = 32,
      image = gTextures['slimeMoveImage'],
      health = 2,
      animation = {
        ['moveDown'] = gAnim8['slimeMove'],
        ['moveUp'] = gAnim8['slimeMove'],
        ['moveRight'] = gAnim8['slimeMove'],
        ['moveLeft'] = gAnim8['slimeMove'],
      },
      collisionBox = {
        ['width'] = 10,
        ['height'] = 10
      },
      idleFrame = 1,
    },
    --[[['boss'] = {
      entityType = 'boss',
      width = 16,
      height = 21,
      x = ENTRY_NORTH_X,
      y = ENTRY_NORTH_Y,
      image = gTextures['bossWalkImage'],
      health = 9,
    },]]
  }