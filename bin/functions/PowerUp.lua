-- Creates powerUp
function powerUp( dt )
	i = math.random(4)
	posX = math.random(10, love.graphics.getWidth() - player.img:getWidth()/2)
	powerUpImg = imagesPowerup[i]
	newPowerUp = {x=posX,y = -10,img = powerUpImg,class = i}
	table.insert(activePowerupOnScreen,newPowerUp)
end

function CheckPowerUp(class)
	if class == 1 then
		player.shield = true
		print('shield')
	elseif class == 2 then
		print('life')
	elseif class == 3 then
		print('Stronger Weapon')
	elseif class == 4 then
		print('Bonus Score')
	end
end