require "libs/mathUtils"
AnimationUtils = require "libs/animationUtils"

Map = require "map"
Player = require "player"
HudTest = require "hud-test"
PNJ = require "pnj"

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

  map_Img = love.graphics.newImage("resources/textures/Parchment.png")
  isMapView = false

  -- Mode debug, permet pour l'instant de visualiser le bord des tuiles ainsi que le FOV du joueur
  debug = false

end

function love.update(dt)

  if fadeInComplete == false and fadeInChrono < fadeInDuration then
    fadeInChrono = fadeInChrono + dt
  elseif fadeInChrono >= fadeInDuration and fadeInComplete == false then
    fadeInComplete = true
  end
  Map:update(dt)
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

  if isMapView then
    love.graphics.setColor(0, 0, 0, 0.8)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(map_Img, love.graphics.getWidth()/2, love.graphics.getHeight()/2, 0, 3, 3, map_Img:getWidth()/2, map_Img:getHeight()/2)
    love.graphics.setColor(0, 0, 0, 1)
    Map:minimap_draw(love.graphics.getWidth()/2, love.graphics.getHeight()/2, 500, 500)
  end

end

function love.keypressed(key, scancode, isrepeat)
  if key == "escape" then
    if isMapView then
      isMapView = false
    else
      isMapView = true
    end
  end
end
