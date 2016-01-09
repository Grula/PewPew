-- Resets game
function restartGame()


	player.shieldImg = playerShieldImg
    player.img = imagesPlayerBasic[2]
    player.bullet = imagesBulletBasic[2]
    backgroundImg = backgroundImges[1]

	-- reset timers
	createEnemyTimer = ENEMY_TIMER

	-- moving player back to default position and reseting player opt
	player.x = 200
	player.y = 690
	player.speed = 350
	player.bulletStrength = 1
	player.bulletDamage = 1.0
	player.life = 3
	player.shield = false
	player.shieldDuration = 0


	-- reseting game state

	enemySpeed = 100		-- speed of what aircrafts are moving
	activeEnemiesOnScreen = {} 
	activeEnemyBulletsOnScreen = {}
	activePowerupOnScreen = {}
	activeBulletsOnScreen = {}

	enemyImg = imagesEnemies[1] 
	enemyBullet = love.graphics.newImage('assets/Space Shooter/PNG/Lasers/laserRed11.png')

	score = 0
	isAlive = true
	scoreUpdate = true
	bonusScore = false

	currentEnemiesAlive = 0
	currentWaveCount = 0
	level = 0
end
