debug = true

--[[
TODO:
	- Lives
	- Score - DONE
	- Levels [enemies life increse,music change,background change]
	- Particles
	- Highscore - DONE
	- Ammo
]]

require("bin.functions.RestartGame")	 -- Function for restarting game
require("bin.functions.Score")			 -- Function for Score/HighScore
require("bin.functions.DrawBackground")	 -- Function for drawing Background
require("bin.functions.PowerUp") 		 -- Function for making PowerUps


isAlive = true
score = 0
dificulty = 5

-- ENTETIES 
player = { x = 200, y = 690, speed = 250, img = nil }
enemies = {} -- array of current enemies on screen
bullets = {} -- array of current bullets being drawn and updated
powers = {}  -- array of current powerups
powerUpsImg = {}-- array of available powerUpsImg

-- TIMERS
canShoot = true
SHOOT_TIMER = 0.5
canShootTimerMax = SHOOT_TIMER
canShootTimer = canShootTimerMax
ENEMY_TIMER = 0.8
createEnemyTimerMax = ENEMY_TIMER
createEnemyTimer = createEnemyTimerMax

-- Image Storage
bulletImg = nil
enemyImg = nil 

backgroundImg1 = nil
backgroundImg2 = nil
powerUpImg = nil

-- Configs
isToDie = true	   -- Checks if player can die
scoreUpdate = true -- Determinates when score needs to be updated at the end of game
Highscore = 0	   -- HighScore loaded from  
SCORE = 0		   -- FINAL score at the end of game

dificulty = 200    -- speed of what aircrafts are moving
level = 0          -- cuurent level
nextLevel = true   -- level changes can occure only once

scoreUp = 0		   -- calculates when we reach 30 points
changeLevel = 30   -- level change on evenry 30 points 

-- PRELOADING ----------------------------------------
function love.load(arg)
	Highscore = LoadHighscore()
	-- LOADING CUSTOM FONT ---------------------------
	font = love.graphics.setNewFont( "bin/KenVector Future Thin.ttf", 14 )
	
	--------------------------------------------------


	-- AUDIO FILES -----------------------------------
	gameSounds = {	'assets/sound/Music/Retro Mystic.ogg',
					'assets/sound/Music/Retro Beat.ogg',
					'assets/sound/Music/Retro Reggae.ogg' }
	

	powerUpSound = love.audio.newSource('assets/sound/powerUp7.ogg')
	pewPewGameSound = love.audio.newSource(gameSounds[1])
	pewPewGameSound:setLooping()
	pewPewGameSound:setVolume(0.5)
	bulletSound = love.audio.newSource('assets/sound/laser4.ogg')
	bulletSound:setVolume(1)
	gameOverSound = love.audio.newSource( 'assets/sound/game_over.ogg' )
	gameOverSound:setVolume(0.6)
	newHighScoreSound = love.audio.newSource('assets/sound/new_highscore.ogg')
	newHighScoreSound:setVolume(0.6)

	--------------------------------------------------


	-- Storing PowerUPsImg in one array ------------------------------------------------
	powerUpsImg = {
		love.graphics.newImage('assets/Space Shooter/PNG/Power-ups/powerupGreen_bolt.png'),
		love.graphics.newImage('assets/Space Shooter/PNG/Power-ups/powerupBlue_star.png'),
		love.graphics.newImage('assets/Space Shooter/PNG/Power-ups/powerupRed_shield.png'),
		love.graphics.newImage('assets/Space Shooter/PNG/Power-ups/things_gold.png')}
	---------------------------------------------------------------------------------



	--print(Highscore)
	--C:\Users\grula\Desktop\Uni\Projects\LUA\projects\Pew Pew\assets\Space Shooter\PNG
	enemyImg = love.graphics.newImage('assets/Space Shooter/PNG/Enemies/enemyGreen1.png')
    player.img = love.graphics.newImage('assets/Space Shooter/PNG/playerShip1_blue.png')
    bulletImg = love.graphics.newImage('assets/Space Shooter/PNG/Lasers/laserBlue01.png')
    backgroundImg = love.graphics.newImage('assets/Space Shooter/Backgrounds/blue.png')

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

	if love.keyboard.isDown(' ', 'rctrl', 'lctrl', 'ctrl') and canShoot and isAlive then
		newBullet = { x = player.x + (player.img:getWidth()/2 - 5), y = player.y - 50, img = bulletImg } 
		table.insert(bullets, newBullet)
		if	bulletSound:isPlaying() then
			bulletSound:stop()
		end
		bulletSound:play()
		canShoot = false
		canShootTimer = canShootTimerMax
	end

	if love.keyboard.isDown('up','w') then
		if player.y > 0 then 
			player.y = player.y - (player.speed*dt)
		end
	elseif love.keyboard.isDown('down','s') then
		if player.y < (love.graphics.getHeight() - player.img:getHeight() - 20 ) then
			player.y = player.y + (player.speed*dt)
		end
	end	
	-----------------------------------------------------


	-- LevelChange ---------------------------------------
	IncreseDif()
	-------------------------------------------------------


	--- SHOOT TIMERS --------------------------------------
	ChecksShootTimer(dt)
	------------------------------------------------------


	-- BULLETS update ------------------------------------
	CheckBullets(dt)
	-------------------------------------------------------


	-- ENEMIES --------------------------------------------
	CreateEnemy(dt)
	--------------------------------------------------------


	-- COLISION --------------------------------------------
	CheckCollisionOfAllEnteties(dt)
	-------------------------------------------------------- 

	-- POWERUPS --------------------------------------------
	powerUp(dt)
	-------------------------------------------------------


	-- GAME RESTART ----------------------------------------
	if not isAlive and isToDie then
		if score < Highscore then
			gameOverSound:play()
		end
		isToDie = false
		enemies = {}
		bullets = {}
	end
	if not isAlive and love.keyboard.isDown('r') then
		-- remove all bullets and enemies from screen
		restartGame()
	end
	-------------------------------------------------------

end



function love.draw(dt)
	-- Drawing Background Image -------------------------
	drawBackground()
	-----------------------------------------------------
	-- BACKGROUND IMAGE/ANIMATION------------------------
	if level == 0 then
		backgroundImg = love.graphics.newImage('assets/Space Shooter/Backgrounds/blue.png')
	-- Level setting 
	elseif level == 1 and nextLevel then
		canShootTimerMax = canShootTimerMax - 0.05
		backgroundImg = love.graphics.newImage('assets/Space Shooter/Backgrounds/purple.png')
		nextLevel = false
		enemies = {}
		enemyImg = love.graphics.newImage('assets/Space Shooter/PNG/Enemies/enemyBlack1.png')
		dificulty = 250
	elseif level == 2 and not nextLevel then
		canShootTimerMax = canShootTimerMax - 0.05
		backgroundImg = love.graphics.newImage('assets/Space Shooter/Backgrounds/darkPurple.png')
		nextLevel = true
		enemies = {}
		dificulty = 300
		enemyImg = love.graphics.newImage('assets/Space Shooter/PNG/Enemies/enemyRed1.png')
	elseif level == 3 then
		-- code
	end

	-----------------------------------------------------


	-- DRAWING PLAYER IF HE IS ALIVE AND SHOWING SCORE---
	-- life is missing
    if isAlive then
		love.graphics.draw(player.img, player.x, player.y)
		love.graphics.print("Score :"..score.." ",0,love.graphics:getHeight()-15)
		love.graphics.print("Highscore: " .. Highscore .. " ",love.graphics:getWidth()-125,love.graphics:getHeight()-15)
	else
		CheckScore(scoreUpdate)
		love.graphics.print("Press 'R' to restart", love.graphics:getWidth()/2-75, love.graphics:getHeight()/2-10)
		love.graphics.print("Score :"..SCORE.." ",0,love.graphics:getHeight()-15)
		love.graphics.print("Highscore: " .. Highscore .. " ",love.graphics:getWidth()-125,love.graphics:getHeight()-15)
	end
	-----------------------------------------------------
	

	-- DRAWING POWERUPSImg ---------------------------------
	for i,powerUp in ipairs(powers) do
		love.graphics.draw(powerUp.img,powerUp.x,powerUp.y)
	end

	-----------------------------------------------------

	-- DRAWING BULLETS AND PARTICLES---------------------
	for i, bullet in ipairs(bullets) do
		love.graphics.draw(bullet.img, bullet.x, bullet.y)
	end

	-----------------------------------------------------


	-- DRAWING ENEMIES ----------------------------------
	for i, enemy in ipairs(enemies) do
		love.graphics.draw(enemy.img, enemy.x, enemy.y)
	end
	-----------------------------------------------------
end



--************************************************************************** FUNCTIONS **************************************************************************
--***************************************************************************************************************************************************************



function IncreseDif()
	if score >= (scoreUp + 10 ) then
		scoreUp = scoreUp + 10 -- 10
		dificulty = dificulty + 50
		if scoreUp == changeLevel then
			changeLevel = changeLevel + 30 -- 30
			level = level + 1
		end
	end
end

-- Timer to be able to shooooooooooooooooooot pewpew -------------------------------------------------------------------------------------------------------------
function ChecksShootTimer( dt )
	canShootTimer = canShootTimer - (1 * dt)
	if canShootTimer < 0 then
	  canShoot = true
	end
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- Checking colision ----------------------------------------------------------------------------------------------------------------------------------------------
function CheckCollisionOfAllEnteties( ... )
	-- If 2 enteties are coliding we are removing them
	for i, enemy in ipairs(enemies) do
		for j, bullet in ipairs(bullets) do
			if CheckCollision(enemy.x, enemy.y, enemy.img:getWidth() , enemy.img:getHeight(), 
							  bullet.x, bullet.y, bullet.img:getWidth(), bullet.img:getHeight()) then
				if enemy.life <= 0 then
					table.remove(enemies, i)
					score = score + 1
				else
					enemy.life = enemy.life - 1
				end
				table.remove(bullets, j)
			end
		end

		if CheckCollision(enemy.x, enemy.y, enemy.img:getWidth(), enemy.img:getHeight(),
						  player.x, player.y, player.img:getWidth(), player.img:getHeight()) 
		and isAlive then
			table.remove(enemies, i)
			isAlive = false
		end
	end
	for i,powerUp in ipairs(powers) do
		if CheckCollision(powerUp.x,powerUp.y,powerUp.img:getWidth(),powerUp.img:getHeight(),
						  player.x, player.y, player.img:getWidth(), player.img:getHeight()) then
			table.remove(powers,i)
			powerUpSound:play()
			player.img = love.graphics.newImage('assets/Space Shooter/PNG/playerShip2_green.png')
		end
	end
end

-- Checks for colision of 2 Enteties
-- Returns true if two boxes overlap, false if they don't
-- x1,y1 are the left-top coords of the first box, while w1,h1 are its width and height
-- x2,y2,w2 & h2 are the same, but for the second box
function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end
---------------------------------------------------------------------------------------------------------------------------------------------------------------------




-- DESTROY/CREATE enteties -------------------------------------------------------------------------------------------------------------------------------

function CheckBullets(dt)
	for i, bullet in ipairs(bullets) do
		bullet.y = bullet.y - (250 * dt)
	  	-- remove bullets when they pass off the screen	
	  	if bullet.y < 0 then 
			table.remove(bullets, i)
		end
	end
end

function CreateEnemy( dt )
	createEnemyTimer = createEnemyTimer - (1 * dt)
	if createEnemyTimer < 0 then
		createEnemyTimer = createEnemyTimerMax
		-- Create an enemy
		randomNumber = math.random(10, love.graphics.getWidth() - enemyImg:getWidth() - 10)
		-- enemy life represents current hitpoits they can take from player, 
		-- showed in lievel
		newEnemy = { x = randomNumber, y = -10, img = enemyImg, life = level }
		table.insert(enemies, newEnemy)
	end
	-- update the positions of enemies
	for i, enemy in ipairs(enemies) do
							--lelel CHANGE
		-- enemy.y = enemy.y + (200 * dt)
		enemy.y = enemy.y + (dificulty * dt)
		-- remove enemies when they pass off the screen
		if enemy.y > love.window.getHeight() - enemy.img:getHeight() - 10  then 
			table.remove(enemies, i)
		end
	end	
end
