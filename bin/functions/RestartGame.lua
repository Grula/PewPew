-- Resets game
function restartGame()

	-- reset timers
	canShootTimer = SHOOT_TIMER
	createEnemyTimer = ENEMY_TIMER
	-- moveing player back to default position
	player.x = 200
	player.y = 690
	-- reseting game state

	enemySpeed = 200		-- speed of what aircrafts are moving
	activeEnemiesOnScreen = {} 
	backgroundImg = love.graphics.newImage('assets/Space Shooter/Backgrounds/blue.png')
	
	score = 0
	isAlive = true
	player.life = 3
	scoreUpdate = true

	scoreUp = 0
	changeLevel = 30
	level = 0
end	powers = {}
