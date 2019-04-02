-- The class file for pipe.

Pipe = Class{}

-- Since a pipe is spanned over and over again, we are using a sigle image to instantiate all the pipes.
local PIPE_IMAGE = love.graphics.newImage('images/pipe.png')

local PIPE_SCROLL = -60 

function Pipe:init()
    self.x = virtual_width
    
    
end
