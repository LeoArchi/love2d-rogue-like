local Player = {

  x,
  y,
  speed,
  fov,

  -- Position à l'écran
  window_x,
  window_y,

  init = function(self, x, y)
    self.x = x or 0
    self.y = y or 0
    self.speed = 100
    self.fov = 300
  end,

  update = function(self, dt)

    local _speed = self.speed*dt

    -- On calcul le delta du joueur par rapport au centre de la carte
    local delta_x = Map.center_x - self.x
    local delta_y = Map.center_y - self.y

    self.window_x = Camera.x - delta_x
    self.window_y = Camera.y - delta_y

    -- Mouvement vertical
    if love.keyboard.isDown("z") then
      self.y = self.y - _speed

      -- Si il reste des éléments en haut de l'écran, on scrolle
      if self.y - self.window_y > 0 then
        Camera.y = Camera.y + _speed
      end

    elseif love.keyboard.isDown("s") then
      self.y = self.y + _speed

      -- Si il reste des éléments en bas de l'écran, on scrolle
      if (Map.rows * Map.cellSize) - self.y - (love.graphics.getHeight() - self.window_y) > 0 then
        Camera.y = Camera.y - _speed
      end

    end

    -- Mouvement horizontal
    if love.keyboard.isDown("q") then
      self.x = self.x - _speed

      -- Si il reste des éléments à gauche de l'écran, on scrolle
      if self.x - self.window_x > 0 then
        Camera.x = Camera.x + _speed
      end

    elseif love.keyboard.isDown("d") then
      self.x = self.x + _speed

      -- Si il reste des éléments à droite de l'écran, on scrolle
      if (Map.columns * Map.cellSize) - self.x - (love.graphics.getWidth() - self.window_x) > 0 then
        Camera.x = Camera.x - _speed
      end

    end

  end,

  draw = function(self)

    love.graphics.push()

    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.print("x:" .. math.floor(self.x) .. " y: " .. math.floor(self.y), self.x, self.y)
    love.graphics.circle("fill", self.x, self.y, 5, 16)
    love.graphics.circle("line", self.x, self.y, self.fov, 64)

    love.graphics.pop()
  end
}

return Player
