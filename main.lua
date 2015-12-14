debug = true

--[[
TODO:
	- Lives
	- Score - DONE
	- Levels [activeEnemiesOnScreen life increse,music change,background change]
	- Particles
	- highscore - DONE
	- Ammo


	funkcije za pomeranje , oko 5-6 njih se biraju random i imaju
	random pattern
]]

require("bin.functions.RestartGame")	 -- Function for restarting game 		----
require("bin.functions.Score")			 -- Function for Score/HighScore 		----
require("bin.functions.DrawBackground")	 -- Function for drawing Background 	----
require("bin.functions.PowerUp") 		 -- Function for making PowerUps 		TODO
require("bin.functions.Audio")			 -- Function for loading Audio files	----
require("bin.functions.Images")			 -- Function for lading Images 			----
require("bin.functions.Level")			 -- Function for changing Levels 		TODO
--require("bin.functions.Variables")

isAlive = true
score = 0

-- ENTETIES 
player = { x = 200, y = 690, speed = 250, img = nil, bullet = nil, life = 3 }


activeEnemiesOnScreen = {} -- array of current activeEnemiesOnScreen on screen
activeBulletsOnScreen = {} -- array of current activeBulletsOnScreen being drawn and updated
activePowerupOnScreen = {} -- array of current powerups



-- TIMERS
SHOOT_TIMER = 0.5
ENEMY_TIMER = 0.8
SCORE = 0 			-- FINAL score at the end of game


canShootCheck = true
canShootTimerMax = SHOOT_TIMER
canShootTimer = canShootTimerMax

createEnemyTimerMax = ENEMY_TIMER
createEnemyTimer = createEnemyTimerMax

-- Configs
isToDie = true	   -- Checks if player can die
scoreUpdate = true -- Determinates when score needs to be updated at the end of game
highscore = nil	   -- HighScore loaded from  
		   

enemySpeed = 200    -- speed of what aircrafts are moving
level = 0          -- cuurent level
nextLevel = true   -- level changes can occure only once

scoreUp = 0		   -- calculates when we reach 30 points
changeLevel = 30   -- level change on evenry 30 points 

POSX = 50
enemyCount = 0


-- PRELOADING ----------------------------------------
function love.load(arg)
	-- Loads CONFIGS
	highscore = LoadHighscore()
	if( highscore ~= nil) then
		print("highscore loaded")
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
		newBullet = { x = player.x + (player.img:getWidth()/2 - 5), y = player.y - 50, img = player.bullet } 
		table.insert(activeBulletsOnScreen, newBullet)
		if	bulletSound:isPlaying() then
			bulletSound:stop()
		end
		bulletSound:play()
		canShootCheck = false
		canShootTimer = canShootTimerMax
	end
	-----------------------------------------------------


---
	-- backgroundImg,nextLevel,canShootTimerMax,activeEnemiesOnScreen,enemyImg,enemySpeed = changeLevel()

	-- if nextLevel then
	-- 	nextLevel = false
	-- else
	-- 	nextLevel = true
	-- end
---


	if level == 0 then
		backgroundImg = love.graphics.newImage('assets/Space Shooter/Backgrounds/blue.png')
	-- Level setting 
	elseif level == 1 and nextLevel then
		canShootTimerMax = canShootTimerMax - 0.05
		backgroundImg = love.graphics.newImage('assets/Space Shooter/Backgrounds/purple.png')
		nextLevel = false
		activeEnemiesOnScreen = {}
		enemyImg = love.graphics.newImage('assets/Space Shooter/PNG/Enemies/enemyBlack1.png')
		enemySpeed = 250
	elseif level == 2 and not nextLevel then
		canShootTimerMax = canShootTimerMax - 0.05
		backgroundImg = love.graphics.newImage('assets/Space Shooter/Backgrounds/darkPurple.png')
		nextLevel = true
		activeEnemiesOnScreen = {}
		enemySpeed = 300
		enemyImg = love.graphics.newImage('assets/Space Shooter/PNG/Enemies/enemyRed1.png')
	elseif level == 3 then
		-- code
	end



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
	if (player.life == 0) and isToDie then
		if score < highscore then
			gameOverSound:play()
		end
		isToDie = false
		--activeEnemiesOnScreen = {}
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
	-- life is missing
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
	

	-- DRAWING POWERUPSImg ---------------------------------
	for i,powerUp in ipairs(activePowerupOnScreen) do
		love.graphics.draw(powerUp.img,powerUp.x,powerUp.y)
	end

	-----------------------------------------------------

	-- DRAWING BULLETS AND PARTICLES---------------------
	for i, bullet in ipairs(activeBulletsOnScreen) do
		love.graphics.draw(player.bullet, bullet.x, bullet.y)
	end

	-----------------------------------------------------


	-- DRAWING ENEMIES ----------------------------------
	for i, enemy in ipairs(activeEnemiesOnScreen) do
		love.graphics.draw(enemy.img, enemy.x, enemy.y)
	end
	-----------------------------------------------------
end



--************************************************************************** FUNCTIONS **************************************************************************
--***************************************************************************************************************************************************************


function IncreseDif()
	if score >= (scoreUp + 10 ) then
		scoreUp = scoreUp + 10 -- 10
		enemySpeed = enemySpeed + 50
		if scoreUp >= changeLevel then
			changeLevel = changeLevel + 30 -- 30
			level = level + 1
		end
	end
end

-- Timer to be able to shooooooooooooooooooot pewpew -------------------------------------------------------------------------------------------------------------
function ChecksShootTimer( dt )
	canShootTimer = canShootTimer - (1 * dt)
	if canShootTimer < 0 then
	  canShootCheck = true
	end
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- Checking colision ----------------------------------------------------------------------------------------------------------------------------------------------
function CheckCollisionOfAllEnteties( ... )
	-- If 2 enteties are coliding we are removing them
	for i, enemy in ipairs(activeEnemiesOnScreen) do
		for j, bullet in ipairs(activeBulletsOnScreen) do
			if CheckCollision(enemy.x, enemy.y, enemy.img:getWidth() , enemy.img:getHeight(), 
							  bullet.x, bullet.y, bullet.img:getWidth(), bullet.img:getHeight()) then
				if enemy.life <= 0 then
					table.remove(activeEnemiesOnScreen, i)
					score = score + 1
				else
					enemy.life = enemy.life - 1
				end
				table.remove(activeBulletsOnScreen, j)
			end
		end

		if CheckCollision(enemy.x, enemy.y, enemy.img:getWidth(), enemy.img:getHeight(),
						  player.x, player.y, player.img:getWidth(), player.img:getHeight()) 
		and (player.life > 0) then
			table.remove(activeEnemiesOnScreen, i)
			player.life = player.life - 1
		end
	end
	for i,powerUp in ipairs(activePowerupOnScreen) do
		if CheckCollision(powerUp.x,powerUp.y,powerUp.img:getWidth(),powerUp.img:getHeight(),
						  player.x, player.y, player.img:getWidth(), player.img:getHeight()) then
			table.remove(activePowerupOnScreen,i)
			powerUpSound:play()
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
	for i, bullet in ipairs(activeBulletsOnScreen) do
		bullet.y = bullet.y - (250 * dt)
	  	-- remove activeBulletsOnScreen when they pass off the screen	
	  	if bullet.y < 0 then 
			table.remove(activeBulletsOnScreen, i)
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
		table.insert(activeEnemiesOnScreen, newEnemy)
	end
	-- update the positions of activeEnemiesOnScreen
	for i, enemy in ipairs(activeEnemiesOnScreen) do
							--lelel CHANGE
		enemy.y = enemy.y + (enemySpeed * dt)
		if enemy.y > love.window.getHeight() - enemy.img:getHeight() - 10  then 
			table.remove(activeEnemiesOnScreen, i)
		end
	end	
end





-- SCORE ------------------------------------------------------------------
function WriteHighscore( score )
	--bin/highscore/
	local file =assert(io.open("bin\\highscore\\highscore.txt","w"),"Error while opening file :(")
	file:write(score)
	file:close()
	return true
end	
function LoadHighscore()
	--C:/Users/grula/Desktop/Uni/Projects/LUA/projects/Pew Pew/
	local file =assert(io.open("C:/Users/grula/Desktop/Uni/Projects/LUA/projects/Pew Pew/bin/highscore/highscore.txt","r"),"Error while opening file :(")
	local line = file:read()
	file:close()
	if line ~= nil then
		return tonumber(line)
	else
		return 0
	end
end
-----------------------------------------------------------------------
