-- This is the flappy birds 2D game.

-- love.graphics.newImage('path')

push = require 'push'

window_width = 1280
window_height = 720

virtual_width = 512
virtual_height = 300

-- create local variables {i.e. it won't be accessable outside this file}
local background = love.graphics.newImage('background.png')
local ground = love.graphics.newImage('ground.png')

function love.load()
    -- Apply nearest neighbour filtering to avoid blurrieness of pictures
    love.graphics.setDefaultFilter('nearest','nearest')

    love.window.setTitle('Flappy Bird')

    push:setupScreen(virtual_width,virtual_height,window_width,window_height,{
        fullscreen=false, resizable=true,vsync=true
    })

end

-- Dynamic rescaling and sizig of the window
function love.resize(w,h)
    push:resize(w,h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

--Render function
function love.draw()
    -- asking push to render screen to virtual resolution
    push:start()
    love.graphics.draw(background,0,0)
    love.graphics.draw(ground,0,virtual_height-16)
    push:finish()
end
