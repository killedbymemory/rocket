require "world"
require "rocket"

function love.load()
  world.load()
  rocket.load()
end

function love.draw()
  world.draw()
  rocket.draw()
end

function love.update(dt)
  rocket.update(dt)
  world.update(dt)
end

function love.keypressed(k)
  rocket.keypressed(k)
end