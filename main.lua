require "libs/mathUtils"

Map = require "map"
Player = require "player"
HudTest = require "hud-test"

function love.load()

  --FadeIn
  fadeInDuration = 2.2
  fadeInChrono = 0
  fadeInComplete = false

  -- Theme
  islandTheme = love.audio.newSource("resources/audio/island.mp3", "stream")
  islandTheme:setLooping(true)
  islandTheme:setVolume(0.3)
  islandTheme:play()

  Map:init()
  HudTest:init()
  Player:init(Map.center_x, Map.center_y) -- On initialise le joueur au centre de la carte

  Camera = {}
  Camera.x = love.graphics.getWidth()/2
  Camera.y = love.graphics.getHeight()/2

end

function love.update(dt)

  if fadeInComplete == false and fadeInChrono < fadeInDuration then
    fadeInChrono = fadeInChrono + dt
  elseif fadeInChrono >= fadeInDuration and fadeInComplete == false then
    fadeInComplete = true
  end

  Player:update(dt)
end

function love.draw()

  love.graphics.setLineWidth(1)

  love.graphics.setBackgroundColor(0.15, 0.15, 0.15, 1)
  Map:draw()
  --HudTest:draw()

  love.graphics.print("TESTORAMA", 10, 10)
  love.graphics.print("Version Alpha 0.1", 10, 25)

  if fadeInComplete == false then

    -- Calcul de l'alpha sur la base de la completion du "FadeIn"
    local delta = fadeInChrono / fadeInDuration

    love.graphics.setColor(0, 0, 0, 1-delta)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
  end

end
