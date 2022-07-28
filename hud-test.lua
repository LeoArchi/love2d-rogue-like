local HudTest = {

  zones,

  init = function(self)

    local gameZoneMargin = 400

    zones = {}

    local top = {x=0, y=0, width=love.graphics.getWidth(), height=gameZoneMargin}
    local right = {x=love.graphics.getWidth()-gameZoneMargin, y=0, width=gameZoneMargin, height=love.graphics.getHeight()}
    local bottom = {x=0, y=love.graphics.getHeight()-gameZoneMargin, width=love.graphics.getWidth(), height=gameZoneMargin}
    local left = {x=0, y=0, width=gameZoneMargin, height=love.graphics.getHeight()}

    table.insert(zones, top)
    table.insert(zones, right)
    table.insert(zones, bottom)
    table.insert(zones, left)

  end,


  draw = function(self)

    love.graphics.push()

    love.graphics.setLineWidth(3)

    for i,zone in ipairs(zones) do
      love.graphics.setColor(1, 1, 1, 0.5)
      love.graphics.rectangle("fill", zone.x, zone.y, zone.width, zone.height)

      love.graphics.setColor(1, 1, 1, 1)
      love.graphics.rectangle("line", zone.x, zone.y, zone.width, zone.height)
    end

    love.graphics.pop()
  end

}

return HudTest
