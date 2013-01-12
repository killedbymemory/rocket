require "world"
require "rocket"

function love.load()
  rocket.load()
end

function love.draw()
  world.draw()
  rocket.draw()
end

function love.update(dt)
  rocket.update(dt)
end