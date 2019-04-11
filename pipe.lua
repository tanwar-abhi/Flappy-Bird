-- The class file for pipe.

Pipe = Class{}

-- Since a pipe is spawned over and over again, we are using a sigle image to instantiate all the pipes.
local PIPE_IMAGE = love.graphics.newImage('images/pipe.png')

local PIPE_SCROLL = -60 

function Pipe:init()
    self.x = virtual_width

    -- random value between the two bounds (upper, lower)
    self.y = math.random(virtual_height/4, virtual_height-10)
    self.width = PIPE_IMAGE:getWidth()

end


function Pipe:update(dt)
    self.x = self.x + PIPE_SCROLL * dt
end


function Pipe:render()
    love.graphics.draw(PIPE_IMAGE, self.x, self.y)
end
