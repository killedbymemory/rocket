require "game"

function love.conf(t)
end

function love.load()
  game.load()
end

function love.draw()
  game.draw()
end

function love.update(dt)
  game.update(dt)
end

function love.keypressed(k)
  game.keypressed(k)
end
