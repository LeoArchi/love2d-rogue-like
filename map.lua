local world_tiles = love.graphics.newImage("resources/textures/world.png")
world_tiles:setFilter("nearest", "nearest")

local water                     = love.graphics.newQuad(16*0, 0, 16, 16, world_tiles)
local grass                     = love.graphics.newQuad(16*1, 0, 16, 16, world_tiles)
local cliff                     = love.graphics.newQuad(16*2, 0, 16, 16, world_tiles)
local cliff_bottom_left_top     = love.graphics.newQuad(16*3, 0, 16, 16, world_tiles)
local cliff_bottom_left_bottom  = love.graphics.newQuad(16*4, 0, 16, 16, world_tiles)
local cliff_bottom_right_top    = love.graphics.newQuad(16*5, 0, 16, 16, world_tiles)
local cliff_bottom_right_bottom = love.graphics.newQuad(16*6, 0, 16, 16, world_tiles)
local cliff_top_left            = love.graphics.newQuad(16*7, 0, 16, 16, world_tiles)
local cliff_top_right           = love.graphics.newQuad(16*8, 0, 16, 16, world_tiles)
local sand                      = love.graphics.newQuad(16*9, 0, 16, 16, world_tiles)
local sand_grass                = love.graphics.newQuad(16*10, 0, 16, 16, world_tiles)
local sand_water                = love.graphics.newQuad(16*11, 0, 16, 16, world_tiles)

local Map = {

  map,
  columns,
  rows,
  center_x,
  center_y,
  cellSize,

  textureRatio,

  init = function(self)
    self.map = {
      { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
      { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
      { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
      { 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0},
      { 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0},
      { 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 2, 2, 2, 2, 2, 3, 1, 1, 1, 1, 1, 0, 0, 0},
      { 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 2, 6, 0, 0, 0, 0, 0, 4, 2, 1, 1, 1, 1, 0, 0, 0},
      { 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0},
      { 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0},
      { 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0},
      { 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 1, 1, 1, 1, 0, 0, 0},
      { 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
      { 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 1, 1, 1, 1, 1, 0, 0, 0},
      { 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0},
      { 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0},
      { 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 7, 0, 0, 0, 0, 0, 0, 8, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0},
      { 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0},
      { 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0},
      { 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0},
      { 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0},
      { 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0},
      { 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0},
      { 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0},
      { 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0},
      { 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0},
      { 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0},
      { 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0},
      { 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0},
      { 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0},
      { 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0},
      { 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0},
      { 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0},
      { 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,10,10,10,10,10,10,10,10,10,10,10, 1, 1, 1, 0, 0, 0},
      { 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 1, 1, 1, 0, 0, 0},
      { 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 2, 2, 2, 2, 2, 3, 1, 1, 1, 1, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 1, 1, 1, 0, 0, 0},
      { 0, 0, 0, 3, 1, 1, 1, 1, 5, 2, 2, 2, 6, 0, 0, 0, 0, 0, 4, 3, 1, 1, 5,11,11,11,11,11,11,11,11,11,11,11, 3, 1, 5, 0, 0, 0},
      { 0, 0, 0, 4, 2, 2, 2, 2, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 2, 2, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 2, 6, 0, 0, 0},
      { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
      { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
      { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
    }

    self.columns = 40
    self.rows = 40

    self.cellSize = 75

    self.textureRatio = self.cellSize / 16 -- Les textures font 16px de coté

    self.center_x = self.columns * self.cellSize /2
    self.center_y = self.rows * self.cellSize /2

    -- Initialisation des pnjs. En multipliant les coordonnées par la taille d'une case, celà permet d'exprimer ces coordonnées en nb de cases au lieux de nb de pixels
    pere_fouras = PNJ:new("Père Fouras", 10 * Map.cellSize, 10 * Map.cellSize, "resources/textures/pere_fouras_idle.png")

  end,

  update = function(self, dt)
    pere_fouras:update(dt)
  end,

  draw = function(self)

    love.graphics.push()

    -- SI LA POSITION DU JOUEUR FAIT EN SORTE QUE LE BORD DE LA CARTE RENTRE A L'INTERIEUR DE L'ECRAN, DEPLACER VISUELLEMENT LE JOUEUR SUR L'ECRAN
    -- SINON, C'EST LA CARTE QUI BOUGE A L'ECRAN ET NON LE JOUEUR (DU MOINS VISUELLEMENT)
    -- TRAITER LES DEUX AXES X ET Y INDEPENDAMENT, CAR PAR EXEMPLE LES BORDS GAUCHE/DROIT DE LA CARTE PEUVENT APPARAITRES ALORS QUE LES BORDS HAUT/BAS SONT ENCORE LOINS

    love.graphics.translate(Camera.x - Map.center_x, Camera.y - Map.center_y)

    for row=1, self.rows do
      for column=1, self.columns do

        local _x = (column - 1) * self.cellSize
        local _y = (row - 1) * self.cellSize

        mapContent = self.map[row][column]

        -- Visualiser le champ de vision du joueur
        if math.getDistance(Player.x, Player.y, _x + self.cellSize/2, _y + self.cellSize/2) <= Player.fov then
          love.graphics.setColor(1, 0.8, 0.8, 1)
        else
          love.graphics.setColor(1, 1, 1, 1)
        end

        -- Fond de la case
        if mapContent == 0 then
          love.graphics.draw(world_tiles, water, _x, _y, 0, self.textureRatio, self.textureRatio)
        elseif mapContent == 1 then
          love.graphics.draw(world_tiles, grass, _x, _y, 0, self.textureRatio, self.textureRatio)
        elseif mapContent == 2 then
          love.graphics.draw(world_tiles, cliff, _x, _y, 0, self.textureRatio, self.textureRatio)

        -- Falaises de face, partie gauche
        elseif mapContent == 3 then
          love.graphics.draw(world_tiles, cliff_bottom_left_top, _x, _y, 0, self.textureRatio, self.textureRatio)
        elseif mapContent == 4 then
          love.graphics.draw(world_tiles, cliff_bottom_left_bottom, _x, _y, 0, self.textureRatio, self.textureRatio)

        -- Falaises de face, partie droite
        elseif mapContent == 5 then
          love.graphics.draw(world_tiles, cliff_bottom_right_top, _x, _y, 0, self.textureRatio, self.textureRatio)
        elseif mapContent == 6 then
          love.graphics.draw(world_tiles, cliff_bottom_right_bottom, _x, _y, 0, self.textureRatio, self.textureRatio)

        -- Falaises de dos
        elseif mapContent == 7 then
          love.graphics.draw(world_tiles, cliff_top_left, _x, _y, 0, self.textureRatio, self.textureRatio)
        elseif mapContent == 8 then
          love.graphics.draw(world_tiles, cliff_top_right, _x, _y, 0, self.textureRatio, self.textureRatio)


        elseif mapContent == 9 then
          love.graphics.draw(world_tiles, sand, _x, _y, 0, self.textureRatio, self.textureRatio)
        elseif mapContent == 10 then
          love.graphics.draw(world_tiles, sand_grass, _x, _y, 0, self.textureRatio, self.textureRatio)
        elseif mapContent == 11 then
          love.graphics.draw(world_tiles, sand_water, _x, _y, 0, self.textureRatio, self.textureRatio)
        end

        -- Le bord de la case
        love.graphics.setColor(0.15, 0.15, 0.15, 1)
        love.graphics.rectangle("line", _x, _y, self.cellSize, self.cellSize)

      end
    end

    -- On dessine les pnj
    pere_fouras:draw()

    -- Avant de quitter le contexte de la carte, on dessine le joueur
    Player:draw()

    love.graphics.pop()
  end

}

return Map
