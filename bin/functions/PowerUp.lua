-- Creates powerUp TODO
function powerUp( dt )
	local randomNumber = math.random(4000)
	if(randomNumber < 3) and (player.life > 0) then
		i = math.random(4)
		posX = math.random(10, love.graphics.getWidth() - enemyImg:getWidth() - 10)
		powerUpImg = imagesPowerup[i]
		print(powerUpImg)
		newPowerUp = {x=posX,y = -10,img = powerUpImg}
		table.insert(activePowerupOnScreen,newPowerUp)
		print("POWER UP")
	end
	for i,powerUp in ipairs(activePowerupOnScreen) do
		powerUp.y = powerUp.y + (150*dt)
		if powerUp.y > love.window.getHeight() - 40 then
			table.remove(activePowerupOnScreen,i)
		end
	end
end