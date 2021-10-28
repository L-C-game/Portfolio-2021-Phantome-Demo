--[[
  Title: The Phantome
  Author: Laura Clarke
  Email: 09.l.clarke.09@gmail.com
  Edx: __L-Clarke__
  GitHub: L-C-game
  Explanation:
  The Game object class
  ]]
  
  GameObject = Class{}
  
  function GameObject:init(def)
    self.type = 'GameObject'
    self.x = def.x
    self.y = def.y
    self.width = def.width
    self.height = def.height
    self.image = def.image
    --clone the animation to prevent all hearts animating together
    self.animation = def.animation:clone()
    --trigger flag for game objects
    self.isTrigger = false

  end
  
  --set up collision
  function GameObject:setUpCollision(bumpWorld)
    bumpWorld:add(self, self.x, self.y, self.width, self.height)
  end
  
  function GameObject:destroyCollision(bumpWorld)
    bumpWorld:remove(self)
  end
  
  function GameObject:update(dt)
    
  end
  
  function GameObject:render()
    
    --if statement, depending on whether or not the enemies have been defeated
    self.animation:draw(self.image, self.x, self.y)
  end