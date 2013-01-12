world = {}

function world.load()
  love.graphics.setBackgroundColor(255,255,255)
end

function world.draw() 
  -- let's draw some ground
  love.graphics.setColor(196,196,196)
  love.graphics.rectangle("fill", 0, 465, 800, 150)
end