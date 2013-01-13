require "world"

rocket = {}

local g, p = love.graphics, love.physics

function rocket.load()
  rocket.widthScale = 1
  rocket.image = rocket.image or g.newImage("assets/rocket_small.png")
  rocket.width = rocket.image:getWidth() * rocket.widthScale
  rocket.height = rocket.image:getHeight()
  rocket.speed = 100;
  rocket.x = (g.getWidth() - rocket.width) / 2
  rocket.y = 100
  rocket.userData = "Rocket"

  --print('rocket width: '..rocket.image:getWidth()..' rocket height: '..rocket.image:getHeight())
  --print('rocket width: '..rocket.width)
  --print('rocket.x: '..rocket.x)
  --print('window width: '..g.getWidth())

  -- ground: body, shape, fixture(body, shape)
  -- body: shape will anchor at body's center
  -- shape: define width and height
  -- fixture: attach shape to body
  world.objects.rocket = {}
  world.objects.rocket.body = p.newBody(world.world, g.getWidth() / 2, rocket.y + (rocket.image:getHeight() / 2), "dynamic")
  world.objects.rocket.shape = p.newRectangleShape(rocket.image:getWidth(), rocket.image:getHeight())
  world.objects.rocket.fixture = p.newFixture(world.objects.rocket.body, world.objects.rocket.shape)
  world.objects.rocket.fixture:setUserData('Rocket');

  -- collision callback
  world.world:setCallbacks(rocket.beginContact, rocket.endContact)
end

function rocket.draw()
  love.graphics.setBackgroundColor(255,255,255)
  g.draw(rocket.image, world.objects.rocket.body:getX() - (rocket.width / 2), world.objects.rocket.body:getY() - (rocket.height / 2), 0, rocket.widthScale)
  
  -- dummy object to get visual of rocket's body:
  -- g.polygon("fill", world.objects.rocket.body:getWorldPoints(world.objects.rocket.shape:getPoints()))
end

function rocket.update(dt)
  if love.keyboard.isDown(" ") then
    -- apply incremental negative impulse from the bottom side
    -- (am not really sure if my interpretation is correct
    -- but, the outcome says so. i come to these numbers after
    -- several test)
		world.objects.rocket.body:applyLinearImpulse(0, -(10 + (dt * 100)))
  end
end

function rocket.keypressed(k)
	if k == " " then
		-- Apply a random impulse
		world.objects.rocket.body:applyLinearImpulse(0, -150)
	end
end

function rocket.beginContact(firstFixture, secondFixture, contact)
  print('rocket.beginContact')
  print('firstFixture:getUserData(): ' .. firstFixture:getUserData())
  print('secondFixture:getUserData(): ' .. secondFixture:getUserData())

  if secondFixture:getUserData() == rocket.userData then
    print('secondFixture:getBody():getLinearVelocity(): ' .. secondFixture:getBody():getLinearVelocity())

    local vx,vy = world.objects.rocket.body:getLinearVelocityFromLocalPoint(g.getWidth() / 2, 465)
    print("rocket.linearVelocity: " .. vx .. "," .. vy)
  end

  
  --local vx, vy = contact:getVelocity()
  --print('contact.getNormal(): ' .. vx .. ',' .. ny)
end

function rocket.endContact(firstFixture, secondFixture, contact)
  print('rocket.endContact')
end


function rocket.postSolve(firstFixture, secondFixture, contact)
  print('rocket.postSolve')
  print('friction: ' .. contact:getFriction())
end