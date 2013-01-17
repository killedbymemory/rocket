require "world"
require "rocket"

game = {}

function game.load()
  world.load()
  rocket.load()
end

function game.draw()
  world.draw()
  rocket.draw()
end

function game.update(dt)
  rocket.update(dt)
  world.update(dt)
end

function game.keypressed(k)
  if k == 'escape' then
    love.event.quit()
  end

  rocket.keypressed(k)
end