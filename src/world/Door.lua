--[[
  Title: The Phantome
  Author: Laura Clarke
  Email: 09.l.clarke.09@gmail.com
  Edx: __L-Clarke__
  GitHub: L-C-game
  Explanation:
  Door object
  ]]
  
  Door = Class{}
  
  function Door:init(def)
    --Type
    self.type = 'Door'
    --Door direction variable
    self.dir = def.dir
    --Locked flag, set in room defs
    self.isLocked = def.isLocked or false
    --Simplifying the code
    self.doorImage = gAnim8['doors']
    --Initialising the position
    self.x, self.y = 0
    --Room connections
    self.connectsTo = def.connectsTo
    --Door modifier
    self.doorMod = 8
    
    --Setting the position and dimensions of the doors
    --dependent on their direction and if they are locked or not
    if self.dir == 'N' and not self.isLocked then
      self.x = NORTH_DOOR_X
      self.y = NORTH_DOOR_Y
      self.width = TILE_SIZE
      self.height = TILE_SIZE
    elseif self.dir == 'N' and self.isLocked then
      self.x = NORTH_DOOR_X
      self.y = NORTH_DOOR_Y
      self.width = TILE_SIZE
      self.height = TILE_SIZE
    elseif self.dir == 'E' and not self.isLocked then
      --Setting the position of the door using constants
      self.x = EAST_DOOR_X
      self.y = EAST_DOOR_Y
      self.width = TILE_SIZE
      self.height = TILE_SIZE
    elseif self.dir == 'E' and self.isLocked then
      --Setting the position of the door using constants
      self.x = EAST_DOOR_X
      self.y = EAST_DOOR_Y
      self.width = TILE_SIZE
      self.height = TILE_SIZE
    elseif self.dir == 'S' and not self.isLocked then
      --Setting the position of the door using constants
      self.x = SOUTH_DOOR_X
      self.y = SOUTH_DOOR_Y
      self.width = TILE_SIZE
      self.height = TILE_SIZE
    elseif self.dir == 'S' and self.isLocked then
      --Setting the position of the door using constants
      self.x = SOUTH_DOOR_X
      self.y = SOUTH_DOOR_Y
      self.width = TILE_SIZE
      self.height = TILE_SIZE
    elseif self.dir == 'W' and not self.isLocked then
      self.x = WEST_DOOR_X
      self.y = WEST_DOOR_Y
      self.width = TILE_SIZE
      self.height = TILE_SIZE
    elseif self.dir == 'W' and self.isLocked then
      self.x = WEST_DOOR_X
      self.y = WEST_DOOR_Y
      self.width = TILE_SIZE
      self.height = TILE_SIZE
    end
    
    --Setting the hitbox position and dimensions of the doors
    --dependent on their direction and if they are locked or not
    if self.dir == 'N' then
      self.hBX = NORTH_DOOR_X
      self.hBY = NORTH_DOOR_Y
      self.hBwidth = TILE_SIZE
      self.hBheight = TILE_SIZE - self.doorMod
    elseif self.dir == 'E' then
      --Setting the position of the door using constants
      self.hBX = EAST_DOOR_X + self.doorMod
      self.hBY = EAST_DOOR_Y
      self.hBwidth = TILE_SIZE - self.doorMod
      self.hBheight = TILE_SIZE
    elseif self.dir == 'S' then
      --Setting the position of the door using constants
      self.hBX = SOUTH_DOOR_X
      self.hBY = SOUTH_DOOR_Y + self.doorMod
      self.hBwidth = TILE_SIZE
      self.hBheight = TILE_SIZE - self.doorMod
    elseif self.dir == 'W' then
      self.hBX = WEST_DOOR_X
      self.hBY = WEST_DOOR_Y
      self.hBwidth = TILE_SIZE - self.doorMod
      self.hBheight = TILE_SIZE
    end
    
  end
  
  function Door:update(dt)

  end

  function Door:setUpCollision(bumpWorld)
    --Door collision
    if self.isLocked == true then
      bumpWorld:add(self, self.x, self.y, self.width, self.height)
    else
      bumpWorld:add(self, self.hBX, self.hBY, self.hBwidth, self.hBheight)
    end
  end
  
  function Door:destroyCollision(bumpWorld)
    bumpWorld:remove(self)
  end

  function Door:render()
    --Rendering room specific doors
    if self.dir == 'N' and self.isLocked == true then
      --Setting the relevant frame of the door
      self.doorImage:gotoFrame(2)
    elseif self.dir == 'N' and self.isLocked == false then
      --Setting the relevant frame of the door
      self.doorImage:gotoFrame(1)
    elseif self.dir == 'W' then
      self.doorImage:gotoFrame(3)
    elseif self.dir == 'E' then
      self.doorImage:gotoFrame(4)
    elseif self.dir == 'S' and self.isLocked == true then
      --Set the relevant door frame
      self.doorImage:gotoFrame(6)
    elseif self.dir == 'S' and self.isLocked == false then
      --Set the relevant door frame
      self.doorImage:gotoFrame(5)
    end
    --Draws the doors depending on the above information
    self.doorImage:draw(gTextures['doors'], self.x, self.y)
  end