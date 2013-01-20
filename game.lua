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
  game.screens.gameOver.fail = game.screens.gameOver.fail or {}
  game.screens.gameOver.fail.image = game.screens.gameOver.fail.image or g.newImage("assets/game_over.png")
  game.screens.gameOver.fail.width = game.screens.gameOver.fail.width or game.screens.gameOver.fail.image:getWidth()
  game.screens.gameOver.fail.height = game.screens.gameOver.fail.height or game.screens.gameOver.fail.image:getHeight()
  game.screens.gameOver.fail.x, game.screens.gameOver.fail.y = 0,0

  game.screens.gameOver.success = game.screens.gameOver.success or {}
  game.screens.gameOver.success.image = game.screens.gameOver.success.image or g.newImage("assets/you_made_it.png")
  game.screens.gameOver.success.width = game.screens.gameOver.success.width or game.screens.gameOver.success.image:getWidth()
  game.screens.gameOver.success.height = game.screens.gameOver.success.height or game.screens.gameOver.success.image:getHeight()
  game.screens.gameOver.success.x, game.screens.gameOver.success.y = 0,0

  -- default game over image would be fail
  game.screens.gameOver.main = game.screens.gameOver.fail

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

  if rocket.isLanded then
    if rocket.isWrecked then
      game.screens.gameOver.main = game.screens.gameOver.fail
    else
      game.screens.gameOver.main = game.screens.gameOver.success
    end

    game.endScreen()
  end

  game.instruction()
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

function game.instruction()
  g.setColor(255,255,255)
  g.print("spacebar: thrust/boost", 10, 10)
  g.print("enter: restart", 10, 25)
  g.print("esc: exit", 10, 40)
end