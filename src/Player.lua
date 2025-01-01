local pd <const> = playdate
local gfx <const> = pd.graphics

local collisionResponses = {
    gfx.sprite.kCollisionTypeSlide,
    gfx.sprite.kCollisionTypeFreeze,
    gfx.sprite.kCollisionTypeOverlap,
    gfx.sprite.kCollisionTypeBounce
}

local collisionResponsesDescription = {
    'kCollisionTypeSlide',
    'kCollisionTypeFreeze',
    'kCollisionTypeOverlap',
    'kCollisionTypeBounce'
}

class('Player').extends(gfx.sprite)
    
function Player:init(x, y, speed, enableRotation)
    self.speed = speed
    self.enableRotation = enableRotation
    self.collisionResponseIndex = 1

    local image <const> 
        = gfx.image.new(32, 32)
    
    gfx.pushContext(image)
    gfx.drawPolygon(16, 0, 31, 31, 0, 31)
    gfx.popContext(image)
    
    self:setImage(image)
    self:setZIndex(0)
    self:setCollideRect(0, 0, 32, 32)
    self:moveTo(x, y)
    self:add()
end

function Player:update()

    if (pd.buttonJustPressed(pd.kButtonA)) then
        self.enableRotation = not self.enableRotation
        print('Enable Rotation: ', self.enableRotation)
    end

    if (pd.buttonJustPressed(pd.kButtonB)) then
        self:setRotation(0)
        print('Reset rotation to: ', self:getRotation())
    end

    if (pd.buttonJustPressed(pd.kButtonUp)) then
        if (self.collisionResponseIndex == 4) then
            self.collisionResponseIndex = 1
        else
            self.collisionResponseIndex = self.collisionResponseIndex + 1
        end
        print('Collision response set: ', collisionResponsesDescription[self.collisionResponseIndex])
    end

    if (pd.buttonJustPressed(pd.kButtonDown)) then
        if (self.collisionResponseIndex == 1) then
            self.collisionResponseIndex = 4
        else
            self.collisionResponseIndex = collisionResponsesDescription.collisionResponseIndex - 1
        end

        print('Collision response set: ', collisionResponses[self.collisionResponseIndex])
    end

    local crankAngleDeg = pd.getCrankPosition()
    local crankAngleRad = math.rad(crankAngleDeg);

    if (self.enableRotation) then
        self:setRotation(crankAngleDeg)
    end

    local xMovement = math.sin(crankAngleRad) * self.speed
    local yMovement = -math.cos(crankAngleRad) * self.speed

    self:moveWithCollisions(self.x + xMovement, self.y + yMovement)
end



function Player:collisionResponse(other)
    return collisionResponses[self.collisionResponseIndex]
end