--[[
  Title: The Phantome
  Author: Laura Clarke
  Email: 09.l.clarke.09@gmail.com
  Edx: __L-Clarke__
  GitHub: L-C-game
  Explanation:
  The room definitions, specific rooms
  ]]
  
  ROOM_DEFS = {
  ['entrance'] = {
    name = 'entrance',
    doorDefs = {
      ['N'] = {
        --Northern door that leads to the boss room
        dir = 'N',
        --locked until the key is acquired
        isLocked = true,
        connectsTo = 'boss_room',
      },
      ['S'] = {
        --Southern door into dungeon, always locked
        dir = 'S',
        isLocked = true,
        connectsTo = 'none',
      },
      ['W'] = {
        --Western door that leads to the treasure room
        dir = 'W',
        connectsTo = 'treasure_room',
      },
    },
  },
  ['treasure_room'] = {
    name = 'treasure_room',
    doorDefs = {
      ['E'] = {
        --Eastern door that leads to the entrance
        dir = 'E',
        connectsTo = 'entrance',
      },
    },
    roomEntities = {
      ['skelly'] = {
        name = 'skelly',
        amount = 1,
      },
      ['slime'] = {
        name = 'slime',
        amount = 1,
      },
    },
    roomGameObjects = {
      ['chest'] = {
        name = 'chest',
        amount = 1,
      },
    },
  },
  ['boss_room'] = {
    name = 'boss_room',
    doorDefs = {
      ['S'] = {
        --Southern door that leads to the entrance
        dir = 'S',
        connectsTo = 'entrance',
      },
    },
    roomGameObjects = {
      ['phantome'] = {
        name = 'phantome',
        amount = 1,
      },
    },
  },
}