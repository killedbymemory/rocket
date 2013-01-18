require "world"
require "rocket"

game = {}
game.over = false

function game.load()
  world.load()
  rocket.load()
  game.start()
end

function game.draw()
  world.draw()
  rocket.draw()
end

function game.update(dt)
  if not game.over then
    rocket.update(dt)
  end

  world.update(dt)

end

function game.keypressed(k)
  if k == 'escape' then
    love.event.quit()
  end

  if k == 'return' then
    -- restart
    love.load()
  end

  if not game.over then
    rocket.keypressed(k)
  end
end

function game.start()
  game.over = false
end

function game.stop()
  game.over = true
end