rocket = {}

local g = love.graphics

function rocket.load()
  rocket.widthScale = .08
  rocket.image = rocket.image or g.newImage("assets/rocket.png")
  rocket.width = rocket.image:getWidth() * rocket.widthScale
  rocket.speed = 100;
  rocket.x = (g.getWidth() - rocket.width) / 2
  rocket.y = 100

  --print('rocket width: '..rocket.image:getWidth()..' rocket height: '..rocket.image:getHeight())
  print('rocket width: '..rocket.width)
  print('rocket.x: '..rocket.x)
  print('window width: '..g.getWidth())
end

function rocket.draw()
  love.graphics.setBackgroundColor(255,255,255)
  g.draw(rocket.image, rocket.x, rocket.y, 0, rocket.widthScale)
end

function rocket.update(dt)
  if love.keyboard.isDown("left") then
    rocket.x = rocket.x - rocket.speed * dt
  end

  if love.keyboard.isDown("right") then
    rocket.x = rocket.x + rocket.speed * dt
  end
  
  if love.keyboard.isDown("up") then
    rocket.y = rocket.y - rocket.speed * dt
  end

  if love.keyboard.isDown("down") then
    rocket.y = rocket.y + rocket.speed * dt
  end
end