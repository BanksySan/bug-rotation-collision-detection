local pd <const> = playdate
local gfx <const> = pd.graphics

class('Wall').extends(gfx.sprite)

function Wall:init(x, y, width, height)
    local image <const> = gfx.image.new(width, height)
    gfx.pushContext(image)
    gfx.drawRect(0, 0, width, height)
    gfx.drawLine(0, 0, width, height)
    gfx.drawLine(0, height, width, 0)
    gfx.popContext(image)
    self:setCollideRect(0, 0, width, height)
    self:setCenter(0,0)
    self:setZIndex(0)
    self:setImage(image)
    self:moveTo(x, y)
    self:add()
end