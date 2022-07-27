local Map = {

  x,
  y,

  map,
  columns,
  rows,
  cellSize,
  cellFont,

  sandTexture,
  rockTexture,

  textureRatio,

  init = function(self)
    self.map = {
      {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
      {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
      {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
      {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
      {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
      {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
      {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
      {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
      {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
      {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
      {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
      {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
      {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
      {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
      {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
      {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
      {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
      {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
      {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
      {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
      {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
      {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
      {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
      {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
    }

    self.columns = 20
    self.rows = 24

    self.cellSize = 50

    self.cellFont = love.graphics.newFont(30)

    self.sandTexture = love.graphics.newImage("resources/textures/sand.png")
    self.rockTexture = love.graphics.newImage("resources/textures/cobblestone.png")

    self.sandTexture:setFilter("nearest", "nearest")
    self.rockTexture:setFilter("nearest", "nearest")

    self.textureRatio = self.cellSize / 16 -- Les textures font 16px de coté

    self.x = love.graphics.getWidth()/2 - self.columns * self.cellSize /2
    self.y = love.graphics.getHeight()/2 - self.rows * self.cellSize /2

  end,

  draw = function(self)

    love.graphics.push()

    -- SI LA POSITION DU JOUEUR FAIT EN SORTE QUE LE BORD DE LA CARTE RENTRE A L'INTERIEUR DE L'ECRAN, DEPLACER VISUELLEMENT LE JOUEUR SUR L'ECRAN
    -- SINON, C'EST LA CARTE QUI BOUGE A L'ECRAN ET NON LE JOUEUR (DU MOINS VISUELLEMENT)
    -- TRAITER LES DEUX AXES X ET Y INDEPENDAMENT, CAR PAR EXEMPLE LES BORDS GAUCHE/DROIT DE LA CARTE PEUVENT APPARAITRES ALORS QUE LES BORDS HAUT/BAS SONT ENCORE LOINS

    -- Centre le joueur au centre de l'écran
    love.graphics.translate(self.x, 0)
    love.graphics.translate(0, self.y)

    -- Translation sur l'axe X
    --love.graphics.translate(-Player.x, 0)

    -- Translation sur l'axe Y
    --love.graphics.translate(0, -Player.y)

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
        local _texture

        if mapContent == 0 then
          _texture = self.sandTexture
        elseif mapContent == 1 then
          _texture = self.rockTexture
        else
          _texture = self.rockTexture
        end

        love.graphics.draw(_texture, _x, _y, 0, self.textureRatio, self.textureRatio)

        -- Le bord de la case
        love.graphics.setColor(0.15, 0.15, 0.15, 1)
        love.graphics.rectangle("line", _x, _y, self.cellSize, self.cellSize)

      end
    end

    -- On affiche les coordonnées de la carte
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.print("x:" .. math.floor(self.x) .. " y:" .. math.floor(self.y), -10, -10)

    -- Avant de quitter le contexte de la carte, on dessine le joueur
    Player:draw()

    love.graphics.pop()
  end

}

return Map
