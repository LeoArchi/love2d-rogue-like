require "libs/mathUtils"

Map = require "map"
Player = require "player"

function love.load()
  Map:init()
  Player:init(Map.columns * Map.cellSize /2, Map.rows * Map.cellSize /2) -- On initialise le joueur au centre de la carte
end

function love.update(dt)
  Player:update(dt)
end

function love.draw()
  love.graphics.setBackgroundColor(0.15, 0.15, 0.15, 1)
  Map:draw()
end
