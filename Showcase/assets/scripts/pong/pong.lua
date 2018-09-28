-- Pong minigame main script

-- Positions and sizes
local courtDimensions = {x = 28, y = 28, w = 1224, h = 664}
local ballSize = {w = 28, h = 28}
local paddleSize = {w = 28, h = 140}
local playerPaddleStartPos = {x = 28, y = 290}
local cpuPaddleStartPos = {x = 1224, y = 290}
local playerScorePos = {x = 438, y = 62}
local cpuScorePos = {x = 758, y = 62}

-- Game objects
local ball, playerPaddle, cpuPaddle, scoreboard

-- Game state
local playerScore = 0
local cpuScore = 0

-- Classes
local function createBall(sprite)
	local ball = {}

	-- Members
	local initialSpeed = 250
	local maxSpeed = 1100
	local speed = initialSpeed
	local direction = {}
	local secondsToGo = 3

	local function normalizeVector(v)
		local length = math.sqrt(v.x * v.x + v.y * v.y)

		return {
			x = v.x / length,
			y = v.y / length
		}
	end

	local function angleDegToVector(angle)
		local angleRad = math.rad(angle)
		
		return {
			x = math.cos(angleRad),
			y = math.sin(angleRad)
		}
	end

	local function collisionWithPaddle(ballX, ballY, paddle)
		local paddleX, paddleY = paddle.getPosition()

		return (ballX + ballSize.w >= paddleX and paddleX + paddleSize.w >= ballX)
				and (ballY + ballSize.h >= paddleY and paddleY + paddleSize.h >= ballY)
	end

	local function bounceWithPaddle(x, y, moveAmount, paddle)
		-- Calculate new direction vector
		local paddleX, paddleY = paddle.getPosition()
		local ballCenter = {x = x + ballSize.w / 2, y = y + ballSize.h / 2}
		local paddleCenter = {x = paddleX + paddleSize.w / 2, y = paddleY + paddleSize.h / 2}

		direction = normalizeVector({
			x = ballCenter.x - paddleCenter.x,
			y = ballCenter.y - paddleCenter.y
		})

		-- Avoid sending the ball too vertically
		local limit = 0.3

		if math.abs(direction.x) < limit then
			if direction.x < 0 then
				direction.x = -limit
			else
				direction.x = limit
			end

			direction = normalizeVector(direction)
		end

		local moveByX = moveAmount * direction.x
		local moveByY = moveAmount * direction.y

		return moveByX, moveByY
	end

	-- Member functions
	ball.center = function()
		-- Place the ball in the center
		local x = courtDimensions.x + courtDimensions.w / 2 - ballSize.w / 2
		local y = courtDimensions.y + courtDimensions.h / 2 - ballSize.h / 2
		sprite:setPosition(x, y)

		-- Select a random direction
		direction = angleDegToVector(math.random(10, 50))

		if math.random(0, 1) == 1 then
			direction.x = -direction.x
		end

		if math.random(0, 1) == 1 then
			direction.y = -direction.y
		end

		-- Wait 3 seconds before movement starts
		secondsToGo = 3

		-- Reduce the speed of the ball
		speed = speed - 100

		if speed < initialSpeed then
			speed = initialSpeed
		end
	end

	ball.reset = function()
		ball.center()
		speed = initialSpeed
	end

	ball.getPosition = function()
		return sprite:getPosition()
	end

	ball.update = function(elapsedSeconds)
		if secondsToGo > 0 then
			-- Wait before starting to move so that the player can react
			secondsToGo = secondsToGo - elapsedSeconds
		else
			-- Move in the current direction
			local x, y = sprite:getPosition()
			local moveAmount = speed * elapsedSeconds
			local moveByX = direction.x * moveAmount
			local moveByY = direction.y * moveAmount
			local bounced = false

			-- Collide with the top and the bottom of the screen
			if y + moveByY < courtDimensions.y or y + ballSize.h + moveByY > courtDimensions.y + courtDimensions.h then
				-- Bounce
				direction.y = -direction.y
				moveByY = -moveByY

				bounced = true
			end

			-- Collide with paddles
			if direction.x < 0 and collisionWithPaddle(x + moveByX, y + moveByY, playerPaddle) then
				moveByX, moveByY = bounceWithPaddle(x, y, moveAmount, playerPaddle)
				bounced = true
			elseif direction.x > 0 and collisionWithPaddle(x + moveByX, y + moveByY, cpuPaddle) then
				moveByX, moveByY = bounceWithPaddle(x, y, moveAmount, cpuPaddle)
				bounced = true
			end

			sprite:setPosition(x + moveByX, y + moveByY)

			-- Score
			if x + moveByX + ballSize.w < 0 then
				cpuScore = cpuScore + 1
				ball.center()
			elseif x + moveByX > courtDimensions.x * 2 + courtDimensions.w then
				playerScore = playerScore + 1
				ball.center()
			end

			if bounced then
				-- Make the ball go faster after a bounce
				speed = speed + 20

				if speed > maxSpeed then
					speed = maxSpeed
				end

				-- Play a sound
				playSound("hover.ogg")
			end
		end
	end

	-- Constructor code
	-- Center and show the sprite
	ball.center()
	sprite:show()

	return ball
end

local function createPaddle(sprite, position, controller)
	local paddle = {}

	-- Members
	local speed = 450

	-- Member functions
	paddle.reset = function()
		sprite:setPosition(position.x, position.y)
		controller.enable()
	end

	paddle.getPosition = function()
		return sprite:getPosition()
	end

	paddle.update = function(elapsedSeconds)
		-- Update position based on controller
		local x, y = sprite:getPosition()
		y = y + speed * controller.getDirection() * elapsedSeconds

		if y < courtDimensions.y then
			y = courtDimensions.y
		elseif y + paddleSize.h > courtDimensions.y + courtDimensions.h then
			y = courtDimensions.y + courtDimensions.h - paddleSize.h
		end

		sprite:setPosition(x, y)
	end

	paddle.onGameFinished = function()
		controller.disable()
	end

	-- Constructor code
	sprite:setPosition(position.x, position.y)
	sprite:show()

	return paddle
end

local function createScoreboard(spritePath)
	local scoreboard = {}

	-- Members
	local playerScoreSprite = Sprite.new(spritePath, 1)
	local cpuScoreSprite = Sprite.new(spritePath, 1)

	-- Member functions
	scoreboard.update = function(elapsedSeconds)
		playerScoreSprite:setFrame(playerScore)
		cpuScoreSprite:setFrame(cpuScore)
	end

	-- Constructor code
	playerScoreSprite:defineSpriteSheet(4, 4, 1, 0)
	playerScoreSprite:setPosition(playerScorePos.x, playerScorePos.y)
	playerScoreSprite:show()

	cpuScoreSprite:defineSpriteSheet(4, 4, 1, 0)
	cpuScoreSprite:setPosition(cpuScorePos.x, cpuScorePos.y)
	cpuScoreSprite:show()

	return scoreboard
end

local function createPlayerController()
	local controller = {}

	-- Members
	local direction = 0
	local map = ClickableMap.new("pongMap.png")

	-- Member functions
	controller.getDirection = function()
		return direction
	end

	controller.enable = function()
		map:enable()
	end

	controller.disable = function()
		map:disable()
	end

	-- Constructor code
	map.disableOnClick = false
	map.nonBlocking = true

	map:setOnMouseEnter(0, function() direction = 0 end)
	map:setOnMouseEnter(1, function() direction = -1 end)
	map:setOnMouseEnter(2, function() direction = 1 end)

	return controller
end

local function createCPUController()
	local controller = {}

	-- Member functions
	controller.getDirection = function()
		local ballX, ballY = ball.getPosition()
		local paddleX, paddleY = cpuPaddle.getPosition()

		local direction = 0

		if ballY - ballSize.h < paddleY then
			direction = -1
		elseif ballY + 2 * ballSize.h > paddleY + paddleSize.h then
			direction = 1
		end

		return direction
	end

	controller.enable = function() end
	controller.disable = function() end

	return controller
end

-- Reset the state of the game
local function resetGame()
	playerScore = 0
	cpuScore = 0

	ball.reset()
	playerPaddle.reset()
	cpuPaddle.reset()
end

-- Check if any of the player has won the game
local function winCondition()
	return playerScore >= 3 or cpuScore >= 3
end

-- End the game
local function endGame()
	-- Disable controllers
	playerPaddle.onGameFinished()
	cpuPaddle.onGameFinished()
end

-- Public interface
pong = {}

-- Initialize the pong minigame
pong.init = function()
	-- Make sure there are no objects in the screen
	scene("black.png", 0)

	-- Display the court as background
	setBackground("pong.png", {type=Transition.dissolve, time=0.3, block=false})

	-- Create the objects for the game
	ball = createBall(Sprite.new("ball.png", 2))
	playerPaddle = createPaddle(Sprite.new("paddle.png", 2), playerPaddleStartPos, createPlayerController())
	cpuPaddle = createPaddle(Sprite.new("paddle.png", 2), cpuPaddleStartPos, createCPUController())
	scoreboard = createScoreboard("score.png")

	-- Wait until the transitions are finished
	sleep(0.3)
end

-- Explain how to play the game
pong.tutorial = function()
	say "Tutorial"
	hideText()
end

-- Start minigame
pong.play = function()
	local frameTime = 0
	local maxFrameTime = 1 / 30

	-- Make sure we don't use the state of a previous game
	resetGame()

	-- Game loop
	while not winCondition() do
		-- Update state of objects
		playerPaddle.update(frameTime)
		cpuPaddle.update(frameTime)
		ball.update(frameTime)
		scoreboard.update(frameTime)

		-- Pause Lua execution and let the engine do
		-- the necessary work to render the next frame
		yield()
		frameTime = math.min(getDeltaSeconds(), maxFrameTime)
	end

	-- Clean
	endGame()
end