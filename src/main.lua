import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/ui"

local pd <const> = playdate
local gfx <const> = pd.graphics

local message = 'Hello World!'
local messageWidth, messageHeight = gfx.getTextSize(message)

local image = gfx.image.new(messageWidth, messageHeight)
gfx.pushContext(image)
gfx.drawText(message, 0, 0, messageWidth, messageHeight, nil, nil, nil)
gfx.popContext(image)

local sprite = gfx.sprite.new()
sprite:setImage(image)
sprite:moveTo(10,10)
sprite:setZIndex(500)
sprite:setScale(2)
sprite:setCenter(0,0)
sprite:add()

function pd:update()
    gfx.clear()
    gfx.sprite.update()
end