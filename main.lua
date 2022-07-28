require "libs/mathUtils"

Map = require "map"
Player = require "player"
HudTest = require "hud-test"

function love.load()
  Map:init()
  HudTest:init()
  Player:init(Map.center_x, Map.center_y) -- On initialise le joueur au centre de la carte

  Camera = {}
  Camera.x = love.graphics.getWidth()/2
  Camera.y = love.graphics.getHeight()/2

end

function love.update(dt)
  Player:update(dt)
end

function love.draw()

  love.graphics.setLineWidth(1)

  love.graphics.setBackgroundColor(0.15, 0.15, 0.15, 1)
  Map:draw()
  --HudTest:draw()

  love.graphics.print("REAL PLAYER POS", 10, 10)
  love.graphics.print("RealPlayerX:" .. math.floor(Player.window_x) .. " RealPlayerY:" .. math.floor(Player.window_y), 10, 25)

end
