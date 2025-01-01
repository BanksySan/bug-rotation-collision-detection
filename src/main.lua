import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/ui"

import "Wall"
import "Player"

local pd <const> = playdate
local gfx <const> = pd.graphics

local playerSpeed = 1

local xOffset <const> = 64
local yOffset <const> = 32

local tileWidth <const> = 16
local tileHeight <const> = 16

local xCount <const> = 12
local yCount <const> = 12

function createTiledWall()

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

    Player(124, 124, playerSpeed, false)
end

function createSolidWall()
    Wall(xOffset, yOffset, tileWidth * xCount, tileHeight)
    Wall(xOffset, yOffset + tileHeight, tileWidth, (yCount - 1) * tileHeight)
    Player(124, 124, playerSpeed, false)
end

local gameModes = {
    createTiledWall,
    createSolidWall
}

local currentMode = 1

gameModes[currentMode]()

function pd:update()
    gfx.clear()
    gfx.sprite.update()

    if (pd.buttonJustPressed(pd.kButtonLeft) or pd.buttonJustPressed(pd.kButtonRight)) then
        if (currentMode == 1) then
            currentMode = 2
        else
            currentMode = 1
        end
        gfx.sprite.removeAll()
        gameModes[currentMode]()
    end
end

