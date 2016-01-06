-- Creates powerUp
function powerUp( dt )
	i = math.random(5)
	posX = math.random(10 , love.graphics.getWidth() - player.img:getWidth()/ 2)
	powerUpImg = imagesPowerup[i]
	print(powerUpImg)	
	newPowerUp = {x=posX,y =-10 ,img = powerUpImg}
	table.insert(activePowerupOnScreen,newPowerUp)
end