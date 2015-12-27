function ChangeLevel()
	if currentLevel < level then
		currentLevel = level
		changeLevel = true
	end

	if changeLevel then
		changeLevel = false
	
		backgroundImg = backgroundImges[currentLevel] 
	 	enemyImg = imagesEnemies[currentLevel]


	 	activeEnemiesOnScreen = {}
	 	currentEnemiesAlive = 0
	end
end