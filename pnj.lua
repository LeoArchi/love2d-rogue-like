local PNJ = {

  x,
  y,
  name,

  idleAnimation,

  new = function(self, name, x, y, spriteSheetPath)
    local _pnj = {}

    setmetatable(_pnj, self)
    self.__index = self

    _pnj.x = x or 0
    _pnj.y = y or 0
    _pnj.name = name or "Anonymous"


    local pere_fouras_spriteSheet = love.graphics.newImage(spriteSheetPath)
    pere_fouras_spriteSheet:setFilter("nearest", "nearest")

    _pnj.idleAnimation = AnimationUtils:new(pere_fouras_spriteSheet, 16, 16, 1, true)

    return _pnj
  end,

  update = function(self, dt)
    self.idleAnimation:update(dt)
  end,

  draw = function(self)
    love.graphics.push()
    love.graphics.setColor(1, 1, 1, 1)
    self.idleAnimation:draw(self.x, self.y, Map.textureRatio, Map.textureRatio)
    love.graphics.pop()
  end

}

return PNJ
