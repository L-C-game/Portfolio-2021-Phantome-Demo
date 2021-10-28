--[[
  Title: The Phantome
  Author: Laura Clarke
  Email: 09.l.clarke.09@gmail.com
  Edx: __L-Clarke__
  GitHub: L-C-game
  Explanation:
  The chest class
  ]]
  
  Chest = Class{__includes = GameObject}
  
  function Chest:init(def)
    GameObject.init(self, def)
    self.gameObjectType = 'chest'
    --intially closed
    self.isOpen = false
    self.openTimer = 0
  end
  
  function Chest:open(room)
    self.room = room
    --set the trigger to true
    self.isTrigger = true
  end
  
  function Chest:update(dt)
    GameObject.update(self, dt)
    --flag enemies vanquished
    if self.isTrigger and not self.isOpen then
      --play the chest's opening animation
      self.animation:update(dt)
      if self.openTimer > 0.2 then
        --spawn the key when the chest is open
        self.key = Key(GAME_OBJECT_DEFS['key'])
        self.key.x = self.x
        self.key.y = self.y + 16
        table.insert(self.room.gameObjects, self.key)
        self.key:setUpCollision(self.room.bumpWorld)
        self.isOpen = true
      else
        --increment the open timer
        self.openTimer = self.openTimer + dt
      end
    end
  end
  
  function Chest:render()
    GameObject.render(self)
  end