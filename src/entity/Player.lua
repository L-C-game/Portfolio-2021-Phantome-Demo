--[[
  Title: The Phantome
  Author: Laura Clarke
  Email: 09.l.clarke.09@gmail.com
  Edx: __L-Clarke__
  GitHub: L-C-game
  Explanation:
  The Player object
  ]]
  
  Player = Class{__includes = Entity}
  
  function Player:init(def)
    Entity.init(self, def)
    self.gotoRoom = 'none'
    --the player instantiates the sword hitbox object
    self.hitbox = Hitbox(HITBOX_DEFS['sword'])
    self.hasKey = false
  end
  
  function Player:update(dt)
    Entity.update(self, dt)
  end
  
  function Player:collisionFilter(item)
    --player specific door collision, to allow room transitions
    local type = item.class.name
    if type == 'Door' then
      if item.isLocked == false and item.isWall == false then
        return "cross"
      end
    else
      return "slide"
    end
  end
  
  function Player:render()
    Entity.render(self)
  end