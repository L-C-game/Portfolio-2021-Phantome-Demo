--[[
  Title: The Phantome
  Author: Laura Clarke
  Email: 09.l.clarke.09@gmail.com
  Edx: __L-Clarke__
  GitHub: L-C-game
  Explanation:
  The key class
  ]]
  
  Key = Class{__includes = GameObject}
  
  function Key:init(def)
    GameObject.init(self, def)
    self.gameObjectType = 'key'
  end
  
  function Key:update(dt)
    GameObject.update(self, dt)
     
  end
  
  function Key:render()
    GameObject.render(self)
  end
  