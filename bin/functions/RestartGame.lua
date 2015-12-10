-- Resets game
function restartGame()
	enemies = {}
	-- reset timers
	canShootTimer = canShootTimerMax
	createEnemyTimer = createEnemyTimerMax
	-- moveing player back to default position
	player.x = 200
	player.y = 690
	-- reseting game state
	dificulty = 200		-- speed of what aircrafts are moving
	score = 0
	isToDie = true
	isAlive = true
	scoreUpdate = true
	tmpScore = score
	level = 0
	powers = {}
end