-- Creates powerUp
function powerUp( dt )
	i = math.random(table.getn(imagesPowerup))
	posX = math.random(10 , love.graphics.getWidth() - player.img:getWidth()/ 2)
	powerUpImg = imagesPowerup[i]
	newPowerUp = {x=posX,y = -10,img = powerUpImg,class = i}
	table.insert(activePowerupOnScreen,newPowerUp)
end

function CheckPowerUp(powerUpClass)
	if powerUpClass == 1 then
		player.shield = true
		player.shieldDuration = 20
		print('Player Shield Active')
	elseif powerUpClass == 2 then
		player.life = player.life + 1
		print('Player Life Active')
	elseif powerUpClass == 3 then
		player.bulletStrength = player.bulletStrength + 1
		print('Stronger Weapon Active')
	elseif powerUpClass == 4 then
		player.bulletDamage = player.bulletDamage + 0.50 
		print('Bullets Damage Active')
	elseif powerUpClass == 5 then
		bonusScore = true 
		bonusScoreDuration = 60
		print('Bonus Score')
	end
end