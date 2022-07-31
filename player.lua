local Player = {

  x,
  y,
  speed,
  fov,

  -- Position à l'écran
  window_x,
  window_y,

  -- Sprite
  spriteSheet,

  -- Orientation
  sprite,
  player_front,
  player_back,
  player_left,
  player_right,

  init = function(self, x, y)
    self.x = x or 0
    self.y = y or 0
    self.speed = 200
    self.fov = 300

    self.spriteSheet =  love.graphics.newImage("resources/textures/player.png")
    self.spriteSheet:setFilter("nearest", "nearest")

    self.player_front = love.graphics.newQuad(0, 0, 16, 16, self.spriteSheet)
    self.player_back = love.graphics.newQuad(16, 0, 16, 16, self.spriteSheet)
    self.player_right = love.graphics.newQuad(32, 0, 16, 16, self.spriteSheet)
    self.player_left = love.graphics.newQuad(48, 0, 16, 16, self.spriteSheet)

    self.sprite = self.player_front
  end,

  update = function(self, dt)

    if isMapView == false then

      local _speed = self.speed*dt

      -- On calcul le delta du joueur par rapport au centre de la carte
      local delta_x = Map.center_x - self.x
      local delta_y = Map.center_y - self.y

      self.window_x = Camera.x - delta_x
      self.window_y = Camera.y - delta_y

      -- Mouvement vertical
      if love.keyboard.isDown("z") then

        self.sprite = self.player_back

        self.y = self.y - _speed

        -- Si il reste des éléments en haut de l'écran, on scrolle
        if self.y - self.window_y > 0 then
          Camera.y = Camera.y + _speed
        end

      elseif love.keyboard.isDown("s") then

        self.sprite = self.player_front

        self.y = self.y + _speed

        -- Si il reste des éléments en bas de l'écran, on scrolle
        if (Map.rows * Map.cellSize) - self.y - (love.graphics.getHeight() - self.window_y) > 0 then
          Camera.y = Camera.y - _speed
        end

      end

      -- Mouvement horizontal
      if love.keyboard.isDown("q") then

        self.sprite = self.player_left

        self.x = self.x - _speed

        -- Si il reste des éléments à gauche de l'écran, on scrolle
        if self.x - self.window_x > 0 then
          Camera.x = Camera.x + _speed
        end

      elseif love.keyboard.isDown("d") then

        self.sprite = self.player_right

        self.x = self.x + _speed

        -- Si il reste des éléments à droite de l'écran, on scrolle
        if (Map.columns * Map.cellSize) - self.x - (love.graphics.getWidth() - self.window_x) > 0 then
          Camera.x = Camera.x - _speed
        end

      end
    end
  end,

  draw = function(self)

    love.graphics.push()

    if debug then
      love.graphics.setColor(1, 0, 0, 1)
      love.graphics.circle("line", self.x, self.y, self.fov, 64)
    end

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.spriteSheet, self.sprite, self.x, self.y, 0, Map.textureRatio, Map.textureRatio, 8, 8)

    love.graphics.pop()
  end
}

return Player
