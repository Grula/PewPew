function ChangeLevel()

	if currentLevel < level then
		currentLevel = level
		changeLevel = true
	end

	if changeLevel then
		changeLevel = false
		
		local picNum = math.mod(currentLevel-1,3)+1		

		backgroundImg = backgroundImges[picNum] 
	 	enemyImg = imagesEnemies[currentLevel]


	 	activeEnemiesOnScreen = {}
	 	currentEnemiesAlive = 0
	end
end