--[[
  Title: The Phantome
  Author: Laura Clarke
  Email: 09.l.clarke.09@gmail.com
  Edx: __L-Clarke__
  GitHub: L-C-game
  Explanation:
  Room class
  ]]
  
  Room = Class{}
  
  function Room:init(def, bumpWorld)
    
    self.bumpWorld = bumpWorld
    
    --Room position
    self.x = MAP_X
    self.y = MAP_Y
    
    --Tile dimensions
    self.tileWidth = TILE_SIZE
    self.tileHeight = TILE_SIZE
    
    --Room dimensions
    self.width = MAP_WIDTH
    self.height = MAP_HEIGHT
    
    --Room tile IDS
    self.tile_top_left_corner = TILE_TOP_LEFT_CORNER
    self.tile_top_right_corner = TILE_TOP_RIGHT_CORNER
    self.tile_bottom_left_corner = TILE_BOTTOM_LEFT_CORNER
    self.tile_bottom_right_corner = TILE_BOTTOM_RIGHT_CORNER
    
    self.tile_floor = TILE_FLOOR 
    
    self.tile_top_walls = TILE_TOP_WALLS
    self.tile_bottom_walls = TILE_BOTTOM_WALLS
    self.tile_left_walls = TILE_LEFT_WALLS
    self.tile_right_walls = TILE_RIGHT_WALLS
    
    self.name = def.name
    
    
    
    --a table to contain the door objects
    self.doors = {}
    --populate the table with the door objects with their respective definitions
    for k, doorDef in pairs(def.doorDefs) do
      table.insert(self.doors, Door(doorDef))
    end
    
    -- set up the wall definitions
    self.wallDefs = WALL_DEFS
    --create a table for the walls
    self.walls = {}
    --fill the walls table
    for k, wall in pairs(self.wallDefs) do
      table.insert(self.walls, Wall(wall))    
    end
    
    --create a table for the walls that are filled, to be populated later
    self.wallFilled = {}
    --each of the directions to compare with the filled walls
    self.wallCheck = {
      'N',
      'E',
      'S',
      'W',
    }
    
    for k, door in pairs(self.doors) do
      --insert the relevant door direction into the wallFilled table
      --this represents the walls that have doors therefore they have filled walls
      table.insert(self.wallFilled, door.dir)
    end
    
    --compare the filled walls with the directions in wall check
    for k, wallCheck in pairs(self.wallCheck) do
      local isFilled = false
      --if the filled wall direction matches that of the wall check then set isFilled to true
      for l, wall in pairs(self.wallFilled) do
        if wall == wallCheck then
          isFilled = true
        end
      end
      --if the wall is not filled then insert a wall into this position as there is no door here
      if not isFilled then
        table.insert(self.wallFilled, wallCheck)
        local defs = {}
        if wallCheck == 'N' then
          defs = {
            name = 'topDummyWall',
            x = NORTH_DOOR_X,
            y = NORTH_DOOR_Y,
            width = 16,
            height = 16,
          }
        elseif wallCheck == 'E' then
          defs = {
            name = 'rightDummyWall',
            x = EAST_DOOR_X,
            y = EAST_DOOR_Y,
            width = 16,
            height = 16,
          }
        elseif wallCheck == 'S' then
          defs = {
            name = 'bottomDummyWall',
            x = SOUTH_DOOR_X,
            y = SOUTH_DOOR_Y,
            width = 16,
            height = 16,
          }
        elseif wallCheck == 'W' then
          defs = {
            name = 'leftDummyWall',
            x = WEST_DOOR_X,
            y = WEST_DOOR_Y,
            width = 16,
            height = 16,
          }
        end
        local wall = Wall(defs)
        table.insert(self.walls, wall)
      end
    end
    
    --entity intialisation
    --table to hold the entities spawning instructions
    self.roomEntities = {}
    -- set up the entity definitions
    self.roomEntities = def.roomEntities
    --create a table for the entities
    self.entities = {}
    if nil ~= self.roomEntities then
      for k, roomEntity in pairs(self.roomEntities) do
        for i = 1, roomEntity.amount do
          table.insert(self.entities, Entity(ENTITY_DEFS[roomEntity.name]))
        end
      end
    end
    
    --gameObject intialisation
    --table to hold the gameObjects spawning instructions
    self.roomGameObjects = {}
    --game object definitions 
    self.roomGameObjects = def.roomGameObjects 
    --table for gameObjects
    self.gameObjects = {}
    if nil ~= self.roomGameObjects then
      for k, roomGameObject in pairs(self.roomGameObjects) do 
        for i = 1, roomGameObject.amount do
          if roomGameObject.name == 'chest' then 
            table.insert(self.gameObjects, Chest(GAME_OBJECT_DEFS[roomGameObject.name]))
          elseif roomGameObject.name == 'phantome' then
            table.insert(self.gameObjects, Phantome(GAME_OBJECT_DEFS[roomGameObject.name]))
          end
        end
      end
    end
    
    --set up enemies for the relevant room
    if nil ~= self.roomEntities then
      for k, entity in pairs(self.entities) do
        --entity state machine
        entity.stateMachine = StateMachine {
          ['walk'] = function() return EntityMoveState(entity, self.bumpWorld) end,
          ['idle'] = function() return EntityIdleState(entity) end,
          --['attack'] = function return PlayerAttackState(self.player) end,
        }
        --Be idle initially
        entity:changeState('idle')
      end
    end
    
  end
  
  function Room:update(dt)
    --destroy enemy collision and remove them from the table if their health drops to 0
    for k, entity in pairs(self.entities) do
      if entity.health < 1 then
        entity:destroyCollision(self.bumpWorld)
        table.remove(self.entities, k)
        --chance of creating a heart game obj, 1/3 chance
        if math.random(3) == 1 then
          heart = Heart(GAME_OBJECT_DEFS['heart'])
          heart.x = entity.x
          heart.y = entity.y
          heart:setUpCollision(self.bumpWorld)
          table.insert(self.gameObjects, heart)
        end
      end
    end
    
    --instantiate the chest
    if nil ~= self.roomGameObjects  then
      if table.getn(self.entities) == 0 then
        for k, gameObject in pairs(self.gameObjects) do
          if gameObject.gameObjectType == 'chest' then
            gameObject:open(self)
          end
        end
      end
    end
    
    --enemy AI update
    if nil ~= self.roomEntities then
      for k, entity in pairs(self.entities) do
        entity:enemyAI(dt)
        entity:update(dt)
      end
    end
    
    --gameobj update
    if nil ~= self.roomGameObjects then
      for k, gameObject in pairs(self.gameObjects) do
        gameObject:update(dt)
        --if the player collides with the heart or key
        if gameObject.gameObjectType == 'heart' or gameObject.gameObjectType == 'key' then
          if gameObject.isTrigger then
            --destroy collision and remove from the table
            gameObject:destroyCollision(self.bumpWorld)
            table.remove(self.gameObjects, k)
          end
        end
      end
    end
    
  end
  
  function Room:setUpCollision(bumpWorld)
    --set up the walls in the bumpWorld
    for k, wall in pairs(self.walls) do
      wall:setUpCollision(bumpWorld)
    end
      
    --Set up the doors in bumpWorld
    for k, door in pairs(self.doors) do
      door:setUpCollision(bumpWorld)
    end  
    --set up collision for the entities
    if nil ~= self.roomEntities then
      for k, entity in pairs(self.entities) do
        entity:setUpCollision(bumpWorld)
      end
    end
    --set up collision for the game objects
    if nil ~= self.roomGameObjects then
      for k, gameObject in pairs(self.gameObjects) do
        gameObject:setUpCollision(bumpWorld)
      end
    end
    
  end
  
  function Room:destroyCollision(bumpWorld)
    --call for every wall destroy collision
    for k, wall in pairs(self.walls) do
      wall:destroyCollision(bumpWorld)
    end
    --call destroy collision for every door
    for k, door in pairs(self.doors) do
      door:destroyCollision(bumpWorld)
    end
    
    --call destroy collision for entities
    if nil ~= self.roomEntities then
      for k, entity in pairs(self.entities) do
        entity:destroyCollision(bumpWorld)
      end
    end
    
    --call destroy collision for game objects
    if nil ~= self.roomGameObjects then
      for k, gameObject in pairs(self.gameObjects) do
        gameObject:destroyCollision(bumpWorld)
      end
    end
    
  end
  
  function Room:render()
    --Rendering the floor tiles
    for x = 1, 10 do
      for y = 1, 7 do
        --To move through the array of floor tile IDs correctly
        tileNum = x + ((y - 1) * 10)
        --Reference to a particular tile
        tile = self.tile_floor[tileNum]
        love.graphics.draw(gTextures['tiles'], gFrames['tiles'][tile], self.x + (x * TILE_SIZE), self.y + (y * TILE_SIZE))
      end
    end
    
    --Render the top left corner tile
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][self.tile_top_left_corner], self.x, self.y)    
    --Render the top right corner tile
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][self.tile_top_right_corner], self.x + (11 * TILE_SIZE), self.y)    
    --Render the bottom left corner tile
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][self.tile_bottom_left_corner], self.x, self.y + (8 * TILE_SIZE))    
    --Render the bottom right corner tile
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][self.tile_bottom_right_corner], self.x + (11 * TILE_SIZE), self.y + (8 * TILE_SIZE))
    
    --Renders the upper wall
    for x, tile in pairs(self.tile_top_walls) do
      love.graphics.draw(gTextures['tiles'], gFrames['tiles'][tile], self.x + (x * TILE_SIZE), self.y)
    end

    --Renders the left hand wall
    for y, tile in pairs(self.tile_left_walls) do
      love.graphics.draw(gTextures['tiles'], gFrames['tiles'][tile], self.x, self.y + (y * TILE_SIZE))
    end
    
    --Renders the lower wall
    for x, tile in pairs(self.tile_bottom_walls) do
      love.graphics.draw(gTextures['tiles'], gFrames['tiles'][tile], self.x + (x * TILE_SIZE), self.y + (8 * TILE_SIZE))
    end
    
    --Renders the right hand wall
    for y, tile in pairs(self.tile_right_walls) do
      love.graphics.draw(gTextures['tiles'], gFrames['tiles'][tile], self.x + (11 * TILE_SIZE), self.y + (y * TILE_SIZE))
    end
    
    --using the door objects render function, render the appropriate doors for the room
    for k, door in pairs(self.doors) do 
      door:render()
    end
    
    --render the room entities
    if nil ~= self.roomEntities then
      for k, entity in pairs(self.entities) do
        entity:render()
      end
    end
    
    --render game objects  
    if nil ~= self.roomGameObjects then
      for k, gameObject in pairs(self.gameObjects) do 
        gameObject:render()
      end
    end
    
  end