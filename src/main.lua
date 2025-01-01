import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/ui"

import "Wall"
import "Player"

local pd <const> = playdate
local gfx <const> = pd.graphics

function createTiledWall()
    local tileWidth <const> = 16
    local tileHeight <const> = 16

    local xCount <const> = 12
    local yCount <const> = 12

    local xOffset <const> = 64
    local yOffset <const> = 32

    local xStop = xOffset + (tileWidth * (xCount - 1))
    local xStep = tileWidth

    local yStop = yOffset + (tileHeight * (yCount - 1))
    local yStep = tileHeight

    Wall(xOffset, yOffset, tileWidth, tileHeight)

    for i = xOffset + tileWidth, xStop, xStep do
        Wall(i, yOffset, tileWidth, tileHeight)
    end

    for j = yOffset + tileHeight, yStop, yStep do
        Wall(xOffset, j, tileWidth, tileHeight)
    end
end

createTiledWall()
Player(124, 124, 1, false)
function pd:update()
    gfx.clear()
    gfx.sprite.update()
end