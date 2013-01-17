rocket = {}
rocket.body = {}
rocket.burst = {}

local g, p = love.graphics, love.physics

function rocket.load()
  rocket.distanceToBurst = 0

  -- rocket body's image and properties
  rocket.body.image = rocket.body.image or g.newImage("assets/rocket_small.png")
  rocket.body.width = rocket.body.image:getWidth()
  rocket.body.height = rocket.body.image:getHeight()
  rocket.body.x = (g.getWidth() - rocket.body.width) / 2
  rocket.body.y = 100
  rocket.userData = "Rocket"


  -- rocket flame burst's image
  rocket.burst.image = rocket.burst.image or g.newImage("assets/rocket_burst_small.png")
  rocket.burst.width = rocket.burst.image:getWidth()
  rocket.burst.height = rocket.burst.image:getHeight()
  rocket.burst.x, rocket.burst.y = 0,0
  rocket.burst.visible = false
  rocket.burst.scaleVertical = 1
  rocket.burst.scaleHorizontal = 1


  -- ground: body, shape, fixture(body, shape)
  -- body: shape will anchor at body's center
  -- shape: define width and height
  -- fixture: attach shape to body
  world.objects.rocket = {}
  world.objects.rocket.body = p.newBody(world.world, g.getWidth() / 2, rocket.body.y + (rocket.body.height / 2), "dynamic")
  world.objects.rocket.shape = p.newRectangleShape(rocket.body.width, rocket.body.height)
  world.objects.rocket.fixture = p.newFixture(world.objects.rocket.body, world.objects.rocket.shape)
  world.objects.rocket.fixture:setUserData(rocket.userData);

  -- collision callback
  world.world:setCallbacks(rocket.beginContact, rocket.endContact)
end

function rocket.draw()
  -- draw rocket's body
  rocket.body.x = world.objects.rocket.body:getX() - (rocket.body.width / 2)
  rocket.body.y = world.objects.rocket.body:getY() - (rocket.body.height / 2)
  g.draw(rocket.body.image, rocket.body.x, rocket.body.y, 0)

  -- draw rocket's flame burst
  if rocket.burst.visible then
    rocket.burst.x = world.objects.rocket.body:getX() - (rocket.burst.width / 2)
    rocket.burst.y = rocket.body.y + rocket.body.height + rocket.distanceToBurst
    g.draw(rocket.burst.image, rocket.burst.x, rocket.burst.y, 0, rocket.burst.scaleHorizontal, rocket.burst.scaleVertical)
  end
  
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

    -- show small burst
    rocket.burst.show(dt)
  else
    rocket.burst.hide()
  end
end

function rocket.keypressed(k)
	if k == " " then
		-- Apply a random impulse
		world.objects.rocket.body:applyLinearImpulse(0, -150)
    rocket.burst.show(0)
	end
end

function rocket.beginContact(firstFixture, secondFixture, contact)
  rocket.burst.hide()

  print('rocket.beginContact')
  print('firstFixture:getUserData(): ' .. firstFixture:getUserData())
  print('secondFixture:getUserData(): ' .. secondFixture:getUserData())

  if secondFixture:getUserData() == rocket.userData then
    print('secondFixture:getBody():getLinearVelocity(): ' .. secondFixture:getBody():getLinearVelocity())

    local vx,vy = world.objects.rocket.body:getLinearVelocityFromLocalPoint(g.getWidth() / 2, 465)
    print("rocket.linearVelocityFromLocalPoint: " .. vx .. "," .. vy)

    vx,vy = world.objects.rocket.body:getLinearVelocityFromLocalPoint(g.getWidth() / 2, 465)
    print("rocket.linearVelocityFromWorldPoint: " .. vx .. "," .. vy)
  end

  
  --local vx, vy = contact:getVelocity()
  --print('contact.getNormal(): ' .. vx .. ',' .. ny)
end

function rocket.burst.show(dt)
  rocket.burst.visible = true
  rocket.burst.scaleVertical = rocket.burst.scaleVertical + (dt / 4)
end

function rocket.burst.hide()
  rocket.burst.visible = false
  rocket.burst.scaleHorizontal,rocket.burst.scaleVertical = 1,1
end