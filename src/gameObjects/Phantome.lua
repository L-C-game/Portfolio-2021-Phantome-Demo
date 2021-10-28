--[[
  Title: The Phantome
  Author: Laura Clarke
  Email: 09.l.clarke.09@gmail.com
  Edx: __L-Clarke__
  GitHub: L-C-game
  Explanation:
  The Phantome class
  ]]
  
 Phantome = Class{__includes = GameObject}
  
  function Phantome:init(def)
    GameObject.init(self, def)
    self.gameObjectType = 'phantome'
  end
  
  function Phantome:update(dt)
    GameObject.update(self, dt)
    --update the animation
    self.animation:update(dt)
    --push the winstate when the phantome is picked up
    if self.isTrigger == true then 
      gSounds['game']:stop()
      gStateStack:pop()
      gStateStack:push(WinState())
    end
  end
  
  function Phantome:render()
    GameObject.render(self)
  end