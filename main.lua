-- This is the flappy birds 2D game.

push = require 'push'

Class = require 'class'

require 'Bird'
require 'pipe'
require 'PipePair'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

virtual_width = 512
virtual_height = 290

-- create local variables {i.e. it won't be accessable outside this file}
local background = love.graphics.newImage('images/background.png')
local ground = love.graphics.newImage('images/ground.png')

-- Keeping track of images {x-axis position} for paralax scrolling
local backgroundScroll = 0
local groundScroll = 0

-- this creates an illusion of the motion
local SPEED_BACKGROUND = 30
local SPEED_GROUND = 60

local BACKGROUND_LOOPING_POINT = 413

local bird = Bird()

-- Keep track of all the pipes that are being spawned
local pipesPairs = {}

-- time to track spawning of each pipe {i.e. after pipe/timer}
local spawnTimer = 0

-- to track the last set of pipe's gap in between.
local lastY = -PIPE_HEIGHT + math.random(80) + 20

function love.load()
    -- Apply nearest neighbour filtering to avoid blurrieness of pictures
    love.graphics.setDefaultFilter('nearest','nearest')

    love.window.setTitle('Flappy Bird')

    push:setupScreen(virtual_width,virtual_height,WINDOW_WIDTH,WINDOW_HEIGHT,{
        fullscreen=false, resizable=true,vsync=true
    })

    math.randomseed(os.time())

    -- creating an empty table "love.keyboard.keysPressed", since in love everything is table except basic variables.
    -- This table is to track the keys pressed.
    love.keyboard.keysPressed = {}
end

-- Dynamic rescaling and sizing of the window
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

-- a custom function to check weither a key was pressed in the last frame or not.
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

    spawnTimer = spawnTimer + dt
    if spawnTimer > 2 then
        table.insert(pipes,Pipe())
        spawnTimer = 0
    end

    bird:update(dt)

    for k, piPe in pairs(pipes) do
        piPe:update(dt)

        if piPe.x < -piPe.width then
            table.remove(pipes,k)
        end

    end

    -- resets the table at every frame.
    love.keyboard.keysPressed = {}

end


--Render function
function love.draw()
    -- asking push to render screen to virtual resolution
    push:start()
    love.graphics.draw(background,-backgroundScroll,0)
    love.graphics.draw(ground,-groundScroll,virtual_height-16)
    
    for k, piPe in pairs(pipes) do
        piPe:render()
    end 

    bird:render()

    push:finish()
end

