--[[
References:
- https://love2d.org/wiki/Tutorial:Physics
]]

world = {}

local g, p = love.graphics, love.physics

function world.load()
  -- world background
  g.setBackgroundColor(255,255,255)

  -- the height of a meter in created world
  p.setMeter(32)

  -- userData
  world.userData = "World"

  -- create a world for the bodies to exist in
  -- horizontal gravity set to 0
  -- vertical gravity set to 9.81
  world.world = p.newWorld(0, 4.5 * 32, true)
  
  -- table to hold all our physical objects
  world.objects = {}

  -- ground: body, shape, fixture(body, shape)
  -- body: shape will anchor at body's center
  -- shape: define width and height
  -- fixture: attach shape to body
  world.objects.ground = {}
  local ground = world.objects.ground
  ground.body = p.newBody(world.world, g.getWidth() / 2, 465 + (150/2))
  ground.shape = p.newRectangleShape(g.getWidth(), 150)
  ground.fixture = p.newFixture(ground.body, ground.shape)
  ground.fixture:setUserData(world.userData)
end

function world.draw() 
  -- draw ground
  g.setColor(196,196,196)
  g.polygon("fill", world.objects.ground.body:getWorldPoints(world.objects.ground.shape:getPoints()))
end

function world.update(dt)
  world.world:update(dt)
end