--[[
  Title: The Phantome
  Author: Laura Clarke
  Email: 09.l.clarke.09@gmail.com
  Edx: __L-Clarke__
  GitHub: L-C-game
  Explanation:
  The Game object definitions
  ]]
  
  GAME_OBJECT_DEFS = {
    ['chest'] = {
      name = 'chest',
      x = NORTH_DOOR_X - 8,
      y  = ENTRY_NORTH_Y,
      width = 16,
      height = 16,
      image = gTextures['chest'],
      animation = gAnim8['chest']
      
    },
    ['key'] = {
      name = 'key',
      x = 0,
      y  = 0,
      width = 16,
      height = 16,
      image = gTextures['key'],
      animation = gAnim8['key']
    },
    ['phantome'] = {
      name = 'phantome',
      x = NORTH_DOOR_X - 8,
      y  = ENTRY_NORTH_Y,
      width = 16,
      height = 16,
      image = gTextures['phantome'],
      animation = gAnim8['phantome']
    },
    ['heart'] = {
      name = 'heart',
      x = 0,
      y = 0,
      width = 16, 
      height = 16,
      image = gTextures['hearts'],
      animation = gAnim8['hearts'],
    },
  }
  