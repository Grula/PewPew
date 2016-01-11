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
					 img = enemyImg, life = level - 1,
					enemyMoveInOneDirection = true}

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
					 img = enemyImg, life = level - 1,
					enemyMoveInOneDirection = true}

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
					 img = enemyImg, life = level - 1,
					enemyMoveInOneDirection = true}

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
					 img = enemyImg, life = level - 1,
					enemyMoveInOneDirection = false}
		table.insert(activeEnemiesOnScreen, newEnemy)
		newEnemy = { x = startingPosXtwo, y = startingPosY,
					 img = enemyImg, life = level - 1,
					enemyMoveInOneDirection = true}
		table.insert(activeEnemiesOnScreen, newEnemy)
		
		startingPosXone = startingPosXone - enemyImg:getWidth()/2 + 20  
		startingPosXtwo = startingPosXtwo + enemyImg:getWidth()/2 - 20

		startingPosY = startingPosY - 150		
	end
	enemyCount = 6
	return enemyCount
end

function EnemyWaveFour(dt)
	local startingPosX = 10
	local startingPosY = -60

	local enemyCount = 6

	while enemyCount > 0 do
		enemyCount = enemyCount - 1
		startingPosX = math.random(10, love.graphics.getWidth() - enemyImg:getWidth() - 10)
		newEnemy = { x = startingPosX, y = startingPosY,
					 img = enemyImg, life = level - 1,
					enemyMoveInOneDirection = true}
		table.insert(activeEnemiesOnScreen, newEnemy)

		startingPosY = startingPosY - 150

	end
	enemyCount = 6
	return enemyCount
end


function EnemyWaveFive( dt )
	local startingPosX = 60
	local startingPosY = -750

	local enemyCount = 6

	while enemyCount > 0 do
		enemyCount = enemyCount - 1
	
		newEnemy = { x = startingPosX, y = startingPosY,
					 img = enemyImg, life = level - 1,
					 enemyMoveInOneDirection = true}
		table.insert(activeEnemiesOnScreen, newEnemy)

		startingPosX = startingPosX + enemyImg:getWidth() - 35
		startingPosY = startingPosY + 100

	end
	enemyCount = 6
	return enemyCount

end



function BossWave( dt )
    
    bossWaveIsUp = true
    newEnemy = { x = 0, y = 0,
					 img = bossImg, life = level - 1,
					 enemyMoveInOneDirection = true}
		table.insert(activeEnemiesOnScreen, newEnemy)
    enemySpeed=100
    activeBulletsOnScreen = {}
   -- bonusScore = True !za ovo nisam sigurna!
    currentEnemiesAlive = 0
     bossBullet=love.graphics.newImage('assets/Space Shooter/PNG/Lasers/LaserGreen10.png')
end