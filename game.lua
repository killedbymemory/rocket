require "world"
require "rocket"

game = {}
game.over = false
game.screens = {}

-- blink
startTime = 0
blinkInterval = .5


local g, t = love.graphics, love.timer

function game.load()
  game.screens.gameOver = game.screens.gameOver or {}
  game.screens.gameOver.main = game.screens.gameOver.main or {}
  game.screens.gameOver.main.image = game.screens.gameOver.main.image or g.newImage("assets/game_over.png")
  game.screens.gameOver.main.width = game.screens.gameOver.main.width or game.screens.gameOver.main.image:getWidth()
  game.screens.gameOver.main.height = game.screens.gameOver.main.height or game.screens.gameOver.main.image:getHeight()
  game.screens.gameOver.main.x, game.screens.gameOver.main.y = 0,0

  game.screens.gameOver.press_start = game.screens.gameOver.press_start or {}
  game.screens.gameOver.press_start.image = game.screens.gameOver.press_start.image or g.newImage("assets/game_over_press_start.png")
  game.screens.gameOver.press_start.width = game.screens.gameOver.press_start.width or game.screens.gameOver.press_start.image:getWidth()
  game.screens.gameOver.press_start.height = game.screens.gameOver.press_start.height or game.screens.gameOver.press_start.image:getHeight()
  game.screens.gameOver.press_start.x, game.screens.gameOver.press_start.y = 0,0
  game.screens.gameOver.press_start.visible = false

  world.load()
  rocket.load()
  game.start()

  startTime = t.getTime()
end

function game.draw()
  world.draw()
  rocket.draw()

  if rocket.isLanded and rocket.isWrecked then
    game.endScreen()
  end
end

function game.update(dt)
  if not game.over then
    rocket.update(dt)
  end

  if t.getTime() - startTime >= blinkInterval then
    startTime = t.getTime()
    game.screens.gameOver.press_start.visible = not game.screens.gameOver.press_start.visible
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
  startTime = t.getTime()
end

function game.endScreen()
  local main, press_start = game.screens.gameOver.main, game.screens.gameOver.press_start
  main.x, main.y = (g.getWidth() - main.width) / 2, ((g.getHeight() - main.height) / 2) - 32
  press_start.x, press_start.y = (g.getWidth() - press_start.width) / 2, main.y + main.height

  -- show game over image
  g.draw(main.image, main.x, main.y)

  -- show press enter to restart every half second
  if game.screens.gameOver.press_start.visible then
    g.draw(press_start.image, press_start.x, press_start.y)
  end
end