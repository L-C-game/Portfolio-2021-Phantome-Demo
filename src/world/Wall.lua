--[[
  Title: The Phantome
  Author: Laura Clarke
  Email: 09.l.clarke.09@gmail.com
  Edx: __L-Clarke__
  GitHub: L-C-game
  Explanation:
  A wall class
  ]]
  
  Wall = Class{}
  
  function Wall:init(def)
    
    self.name = def.name
    
    --Wall position
    self.x = def.x
    self.y = def.y
    --Wall dimensions
    self.width = def.width
    self.height = def.height
  
  end
  
  function Wall:update(dt)
    
  end
  
  function Wall:setUpCollision(bumpWorld)
    --Wall collision
    bumpWorld:add(self, self.x, self.y, self.width, self.height)
  end
  
  function Wall:destroyCollision(bumpWorld)
    bumpWorld:remove(self)
  end
  
  function Wall:render()

  end
  
  
  
  