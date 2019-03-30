-- This is the flappy birds 2D game.

push = require 'push'

Class = require 'class'

require 'Bird'

window_width = 1280
window_height = 720

virtual_width = 512
virtual_height = 300

-- create local variables {i.e. it won't be accessable outside this file}
local background = love.graphics.newImage('background.png')
local ground = love.graphics.newImage('ground.png')

-- Keeping track of images {x-axis position} for paralax scrolling
local backgroundScroll = 0
local groundScroll = 0

-- this creates an illusion of the motion
local SPEED_BACKGROUND = 30
local SPEED_GROUND = 60

local BACKGROUND_LOOPING_POINT = 413

local bird = Bird()

function love.load()
    -- Apply nearest neighbour filtering to avoid blurrieness of pictures
    love.graphics.setDefaultFilter('nearest','nearest')

    love.window.setTitle('Flappy Bird')

    push:setupScreen(virtual_width,virtual_height,window_width,window_height,{
        fullscreen=false, resizable=true,vsync=true
    })

    -- creating an empty table "love.keyboard", since in love everything is table except basic variables.
    love.keyboard.keysPressed = {}
end

-- Dynamic rescaling and sizig of the window
function love.resize(w,h)
    push:resize(w,h)
end

function love.keypressed(key)
    -- Populates the table with info on which key is pressed.
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end

end


function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end



function love.update(dt)
    backgroundScroll = (backgroundScroll + SPEED_BACKGROUND * dt) % BACKGROUND_LOOPING_POINT

    groundScroll = (groundScroll + SPEED_GROUND * dt ) % virtual_width

    bird:update(dt)

    -- resets the table at every frame rate
    love.keyboard.keysPressed = {}

end


--Render function
function love.draw()
    -- asking push to render screen to virtual resolution
    push:start()
    love.graphics.draw(background,-backgroundScroll,0)
    love.graphics.draw(ground,-groundScroll,virtual_height-16)

    bird:render()

    push:finish()
end
