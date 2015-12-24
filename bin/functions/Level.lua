function changeLevel()
	if level == 0 then
		backgroundImg = love.graphics.newImage('assets/Space Shooter/Backgrounds/blue.png')
	-- Level setting 
	elseif level == 1 and nextLevel then

		canShootTimerMax = canShootTimerMax - 0.05
		backgroundImg = love.graphics.newImage('assets/Space Shooter/Backgrounds/purple.png')
		nextLevel = false
		enemies = {}
		enemyImg = love.graphics.newImage('assets/Space Shooter/PNG/Enemies/enemyBlack1.png')
		dificulty = dificulty + 50

	elseif level == 2 and not nextLevel then

		canShootTimerMax = canShootTimerMax - 0.05
		backgroundImg = love.graphics.newImage('assets/Space Shooter/Backgrounds/darkPurple.png')
		nextLevel = true
		enemies = {}
		dificulty = dificulty + 50
		enemyImg = love.graphics.newImage('assets/Space Shooter/PNG/Enemies/enemyRed1.png')

	elseif level == 3 then
		--
	end
	return true
end