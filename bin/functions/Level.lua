function ChangeLevel()

	if currentLevel < level then
		currentLevel = level
		changeLevel = true
	end

	if changeLevel then
		changeLevel = false
		
		local picNum = math.mod(currentLevel-1,table.getn(backgroundImges))+1		

		backgroundImg = backgroundImges[picNum] 

		picNum = math.mod(currentLevel-1,table.getn(imagesEnemies))+1
	 	enemyImg = imagesEnemies[picNum]


	 	activeEnemiesOnScreen = {}
	 	currentEnemiesAlive = 0
	end
end

function IncreseDif()
	-- local boss = math.mod(level,2)
	-- if boss == 0 then
	-- 	bossLevel = true
	-- end
	if currentWaveCount > 5 and (score >= ((level)*25))then -- and not bossLevel then -- 5 , 25
		level = level + 1
		powerUp()
		if enemySpeed < 300 then
			enemySpeed = enemySpeed + 15
		end
		currentWaveCount = 0 
		if player.speed < 400 then
			player.speed = player.speed + 10
		end
	end
	-- if bossLevel then
	-- 	BossWave()
	-- 	print('bossLevel')
	-- end
end