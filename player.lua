local Player = {

  x,
  y,
  speed,
  fov,

  init = function(self, x, y)
    self.x = x or 0
    self.y = y or 0
    self.speed = 100
    self.fov = 300
  end,

  update = function(self, dt)
    if love.keyboard.isDown("z") then
      self.y = self.y - self.speed*dt
      Map.y = Map.y + self.speed*dt
    elseif love.keyboard.isDown("s") then
      self.y = self.y + self.speed*dt
      Map.y = Map.y - self.speed*dt
    end


    if love.keyboard.isDown("q") then
      self.x = self.x - self.speed*dt
      Map.x = Map.x + self.speed*dt
    elseif love.keyboard.isDown("d") then
      self.x = self.x + self.speed*dt
      Map.x = Map.x - self.speed*dt
    end

    -- On "cap" la position de la map
    --if Map.x < 0 then Map.x = 0 end
    --if Map.x + Map.columns * Map.cellSize > love.graphics.getWidth() then Map.x = love.graphics.getWidth() - Map.columns * Map.cellSize end

    --if Map.y < 0 then Map.y = 0 end
    --if Map.y + Map.rows * Map.cellSize > love.graphics.getHeight() then Map.y = love.graphics.getHeight() - Map.rows * Map.cellSize end

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
