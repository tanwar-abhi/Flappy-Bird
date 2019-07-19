-- The class file for Bird

-- Creating a class with name "Bird"
Bird = Class{}

local GRAVITY = 20

-- Jump height
local ANTI_GRAVITY = -5


-- Initialization of Bird Class
function Bird:init()
    self.image = love.graphics.newImage('images/bird.png')

    -- Gets the width and height from the image file used above
    self.height = self.image:getHeight()
    self.width = self.image:getWidth()

    -- Position of object on the screen {center of screen in this case}
    self.x = virtual_width/2 - self.width/2
    self.y = virtual_height/2 - self.height/2
    self.dy = 0
end


function Bird:render()
    love.graphics.draw(self.image,self.x,self.y)
end


function Bird:update(dt)
    -- Setting speed of fall
    self.dy = self.dy +  GRAVITY*dt

    self.y = self.y + self.dy

    if love.keyboard.wasPressed('space') then
        -- self.dy = self.dy - GRAVITY*dt
        self.dy = ANTI_GRAVITY
    end
end
