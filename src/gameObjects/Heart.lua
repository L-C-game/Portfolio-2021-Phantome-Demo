--[[
  Title: The Phantome
  Author: Laura Clarke
  Email: 09.l.clarke.09@gmail.com
  Edx: __L-Clarke__
  GitHub: L-C-game
  Explanation:
  The heart class
  ]]
  
  Heart = Class{__includes = GameObject}
  
  function Heart:init(def)
    GameObject.init(self, def)
    self.gameObjectType = 'heart'
  end
  
  function Heart:update(dt)
    GameObject.update(self, dt)
     
  end
  
  function Heart:render()
    GameObject.render(self)
  end