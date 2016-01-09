debug = true


require("bin.functions.RestartGame")	 -- Function for restarting game 		TODO
require("bin.functions.Score")			 -- Function for Score/HighScore 		----
require("bin.functions.DrawBackground")	 -- Function for drawing Background 	----
require("bin.functions.PowerUp") 		 -- Function for making PowerUps 		TODO
require("bin.functions.Audio")			 -- Function for loading Audio files	ADD-
require("bin.functions.Images")			 -- Function for lading Images 			ADD-
require("bin.functions.Level")			 -- Function for changing Levels 		TODO
require("bin.functions.Updates")
require("bin.functions.EnemyWaves")
require("bin.functions.Weapon")
require("bin.functions.Collision")


score = 0

-- ENTETIES 
-- player cant have more then 9 lives
player = { x = 200, y = 690,
		   speed = 350,
		   img = nil,
		   bullet = nil, bulletStrength = 1, bulletDamage = 1.0,
		   life = 3,
		   shield = false, shieldDuration = 0, shieldImg = nil
		 }


activeEnemiesOnScreen = {} -- array of current activeEnemiesOnScreen on screen
activeBulletsOnScreen = {} -- array of current activeBulletsOnScreen being drawn and updated
activePowerupOnScreen = {} -- array of current powerups
activeEnemyBulletsOnScreen = {}

currentEnemiesAlive = 0
currentWaveCount = 0
enemyWaves = { EnemyWaveOne,EnemyWaveTwo,EnemyWaveThree,EnemyWaveFour,EnemyWaveFive}

-- CONSTANTS
SHOOT_TIMER = 0.45
ENEMY_TIMER = 0.8
SCORE = 0 			-- FINAL score at the end of game


canShootCheck = true
canShootTimerMax = SHOOT_TIMER
canShootTimer = canShootTimerMax

createEnemyTimerMax = ENEMY_TIMER
createEnemyTimer = createEnemyTimerMax

-- Configs
isAlive = true	   -- Checks if player is alive
scoreUpdate = true -- Determinates when score needs to be updated at the end of game
highscore = nil	   -- HighScore loaded from  file
bonusScore = false	-- Checks if bonus score is active
bonusScoreDuration = 0		   -- Remaining time of bonus score :)


weaponUpdate = true	-- checking if we got an powerUp so we slow down shooting
enemySpeed = 100    -- speed of what aircrafts are moving
level = 1	       -- cuurent level
nextLevel = true   -- level changes can occure only once


currentPlayerBulletDamage = 1

-- Variables used in function changeLevel()
currentLevel = 1 
changeLevel = false




-- PRELOADING ----------------------------------------
function love.load(arg)
	-- Loads CONFIGS
	highscore = LoadHighscore()
	if( highscore ~= nil) then
		print("highscore loaded")
	else
		highscore = 0
	end
	-- LOADING CUSTOM FONT ---------------------------
	font = love.graphics.setNewFont( "bin/KenVector Future Thin.ttf", 14 )
	--------------------------------------------------

	-- Loads Audio files
	if loadAudio() then
		print("Audio loaded")
	end

	-- Loading Images
	if loadImages() then
		print("Images loaded")
	end
end


function love.update(dt)
	-- Playing Game sound in background
	pewPewGameSound:play()
	--print(love.timer.getFPS())

	-- KEYBOARD EVENETS ---------------------------------	
	if love.keyboard.isDown('escape') then
		love.event.push('quit')
	end
	if love.keyboard.isDown('left','a') then
		if player.x > 0 then -- binds us to the map
			player.x = player.x - (player.speed*dt)
		end
	elseif love.keyboard.isDown('right','d') then
		if player.x < (love.graphics.getWidth() - player.img:getWidth()) then
			player.x = player.x + (player.speed*dt)
		end
	end

	if love.keyboard.isDown(' ', 'rctrl', 'lctrl', 'ctrl') and canShootCheck and (player.life > 0) then
		MakeBullets() 
	end


	-- Enemy shooting(Updates)
	EnemyShoot()

	-- updating shield duration
	UpdateShield(dt)
	--

	-- Updating bonus score duration!
	UpdateBonusScore(dt)

	--

	--Updating visuals of bullets(lazors)
	UpdateVisualLasers()
	--


	-- LevelChange ---------------------------------------
	IncreseDif()

	-- Game crashes after 3rd level , images of enemies needs to be added
	-- or reseted to lower value
	ChangeLevel()

	-------------------------------------------------------


	--- SHOOT TIMERS --------------------------------------
	ChecksShootTimer(dt)
	------------------------------------------------------


	-- BULLETS update ------------------------------------
	CheckBullets(dt)
	CheckEnemyBullets(dt)
	-------------------------------------------------------


	-- ENEMIES --------------------------------------------
	CreateEnemy(dt)
	--------------------------------------------------------


	-- COLISION --------------------------------------------
	CheckCollisionOfAllEnteties(dt)
	-------------------------------------------------------- 

	-- POWERUPS --------------------------------------------
	local randomNumber = math.random(4000)
	if(randomNumber < 3) and (player.life > 0) then
		powerUp(dt)
	end
	-------------------------------------------------------


	-- GAME RESTART ----------------------------------------
	if (player.life == 0) and isAlive then
		if score < highscore then
			gameOverSound:play()
		end
		player.shield = false
		isAlive = false
		activeBulletsOnScreen = {}
	end
	if (player.life == 0) and love.keyboard.isDown('r') then
		-- remove all activeBulletsOnScreen and activeEnemiesOnScreen from screen
		restartGame()
	end
	-------------------------------------------------------

end



function love.draw(dt)
	-- Drawing Background Image -------------------------
	drawBackground()
	-----------------------------------------------------


	-- DRAWING PLAYER IF HE IS ALIVE AND SHOWING SCORE---
    if (player.life > 0) then
		love.graphics.draw(player.img, player.x, player.y)
		love.graphics.print("Score :"..score.." ",0,love.graphics:getHeight()-15)
		love.graphics.print("highscore: " .. highscore .. " ",love.graphics:getWidth()-125,love.graphics:getHeight()-15)
	else
		CheckScore()
		love.graphics.print("Press 'R' to restart", love.graphics:getWidth()/2-75, love.graphics:getHeight()/2-10)
		love.graphics.print("Score :"..SCORE.." ",0,love.graphics:getHeight()-15)
		love.graphics.print("highscore: " .. highscore .. " ",love.graphics:getWidth()-125,love.graphics:getHeight()-15)
	end
	-----------------------------------------------------

	-- Life icons drawing
	local startX = love.graphics:getWidth()/2-75
	local startY = love.graphics:getHeight()-25
	local x = startX
	local y = startY
	for i=1,player.life do
		if player.life > 4 then
			if player.life > 9 then
				player.life = 9
			end
				love.graphics.draw(imagesLifeNumerals[player.life+1],x,y)
				love.graphics.draw(imagesLifeNumerals[11],x+imagesLifeNumerals[player.life+1]:getWidth()+5,y)
				love.graphics.draw(playerLifeImg,x+imagesLifeNumerals[player.life+1]:getWidth()*2+7,y-5)
			break
		end
		love.graphics.draw(playerLifeImg,x,y-5)
		x = x + playerLifeImg:getWidth()+2
	end
	--

	-- DRAWING POWERUPSImg ---------------------------------
	for i,powerUp in ipairs(activePowerupOnScreen) do
		love.graphics.draw(powerUp.img,powerUp.x,powerUp.y)
	end


	-----------------------------------------------------

	-- DRAWING BULLETS AND PARTICLES---------------------
	for i, bullet in ipairs(activeBulletsOnScreen) do
		love.graphics.draw(player.bullet, bullet.x, bullet.y)
	end

	for i, bullet in ipairs(activeEnemyBulletsOnScreen) do
		love.graphics.draw(enemyBullet, bullet.x, bullet.y)
	end
	-----------------------------------------------------


	-- DRAWING ENEMIES ----------------------------------
	for i, enemy in ipairs(activeEnemiesOnScreen) do
		love.graphics.draw(enemy.img, enemy.x, enemy.y)
	end
	-----------------------------------------------------

	if player.shield then
		love.graphics.draw(player.shieldImg,player.x-17,player.y-17)
	end

end



--************************************************************************** FUNCTIONS **************************************************************************
--***************************************************************************************************************************************************************


function CreateEnemy( dt )

	if currentEnemiesAlive <= 0 then
		i = math.random(1,table.maxn(enemyWaves))
		currentEnemiesAlive = enemyWaves[i]()
		currentWaveCount = currentWaveCount + 1
	end

	for i, enemy in ipairs(activeEnemiesOnScreen) do
		enemy.y = enemy.y + (enemySpeed * dt)
		if enemy.enemyMoveInOneDirection then
			enemy.x = enemy.x + (enemySpeed * dt)
			if enemy.x > love.window.getWidth()-enemy.img:getWidth() then
				enemy.enemyMoveInOneDirection = false
			end
		else
			enemy.x = enemy.x - (enemySpeed * dt)
			if enemy.x < 0 then
				enemy.enemyMoveInOneDirection = true
			end
		end

		if enemy.y > love.window.getHeight() - enemy.img:getHeight() - 10  then 
			table.remove(activeEnemiesOnScreen, i)
			currentEnemiesAlive = currentEnemiesAlive - 1
		end
	end	

end



