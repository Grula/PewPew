function EnemyWaveOne(dt)

	-- *
	-- 		*
	-- *
	-- 		*
	-- *
	-- 		*

	local startingPosXone = love.window.getWidth()/4
	local startingPosXtwo = love.window.getWidth()/2 + 50
	local startingPosY = - 60
	local odd = true
	local x = 1

	local enemyCount = 6

	while enemyCount > 0 do
		enemyCount = enemyCount - 1
		if odd then
			x = startingPosXone
			odd = false
		else
			x = startingPosXtwo
			odd = true
		end 

		startingPosY = startingPosY - 90

		newEnemy = { x = x, y = startingPosY,
					 img = enemyImg, life = level - 1}

		table.insert(activeEnemiesOnScreen, newEnemy)
	end
	enemyCount = 6
	return enemyCount
end

function EnemyWaveTwo(dt)
	local startingPosX = 20
	local startingPosY = - 10
	local trio = 3

	local enemyCount = 5

	while enemyCount > 0 do
		enemyCount = enemyCount - 1
		if trio > 0 then 
			trio = trio - 1
			startingPosX = startingPosX + enemyImg:getWidth() + 5
		elseif trio == -3 then
			startingPosX = 20
		elseif trio <= 0 then
			startingPosX = startingPosX - enemyImg:getWidth() - 5
		end

		startingPosY = startingPosY - 90

		newEnemy = { x = startingPosX, y = startingPosY,
					 img = enemyImg, life = level - 1}

		table.insert(activeEnemiesOnScreen, newEnemy)
	end
	enemyCount = 5
	return enemyCount
end

function EnemyWaveTwo(dt)
	local startingPosX = 20
	local startingPosY = - 60
	local trio = 3

	local enemyCount = 5

	while enemyCount > 0 do
		enemyCount = enemyCount - 1
		if trio > 0 then 
			trio = trio - 1
			startingPosX = startingPosX + enemyImg:getWidth() + 5
		elseif trio == -3 then
			startingPosX = 20
		elseif trio <= 0 then
			startingPosX = startingPosX - enemyImg:getWidth() - 5
		end

		startingPosY = startingPosY - 90

		newEnemy = { x = startingPosX, y = startingPosY,
					 img = enemyImg, life = level - 1}

		table.insert(activeEnemiesOnScreen, newEnemy)
	end
	enemyCount = 5
	return enemyCount
end

function EnemyWaveThree(dt)
	local startingPosXone = love.window.getWidth()/2 - enemyImg:getWidth() - 40
	local startingPosXtwo = love.window.getWidth()/2 + enemyImg:getWidth() - 40
	local startingPosY = - 60
	local trio = 3

	local enemyCount = 6

	while enemyCount > 0 do
		enemyCount = enemyCount - 2


		newEnemy = { x = startingPosXone, y = startingPosY,
					 img = enemyImg, life = level - 1}
		table.insert(activeEnemiesOnScreen, newEnemy)
		newEnemy = { x = startingPosXtwo, y = startingPosY,
					 img = enemyImg, life = level - 1}
		table.insert(activeEnemiesOnScreen, newEnemy)
		
		startingPosXone = startingPosXone - enemyImg:getWidth()/2 + 20  
		startingPosXtwo = startingPosXtwo + enemyImg:getWidth()/2 - 20

		startingPosY = startingPosY - 150


		
	end
	enemyCount = 6
	return enemyCount
end

	-- createEnemyTimer = createEnemyTimer - (1 * dt)
	-- if createEnemyTimer < 0 then
	-- 	createEnemyTimer = createEnemyTimerMax
	-- 	randomNumber = math.random(10, love.graphics.getWidth() - enemyImg:getWidth() - 10)
	-- 	-- enemy life represents current hitpoits they can take from player, 
	-- 	-- showed in current level (exp. level = 3 , enemy can take 3 hits)
	-- 	newEnemy = { x = randomNumber, y = -10, img = enemyImg, life = level - 1}
	-- 	table.insert(activeEnemiesOnScreen, newEnemy)
	-- end
	-- update the positions of activeEnemiesOnScreen