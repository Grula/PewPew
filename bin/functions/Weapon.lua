function MakeBullets( ... )
	
	if player.bulletStrength == 2 then

		if weaponUpdate then
			print(weaponUpdate)
			canShootTimerMax = canShootTimerMax + 0.05
			weaponUpdate = false
		end


		newBullet = { x = player.x, y = player.y - 50, img = player.bullet } 
		table.insert(activeBulletsOnScreen, newBullet)
		newBullet = { x = player.x + player.img:getWidth() -10, y = player.y - 50, img = player.bullet } 
		table.insert(activeBulletsOnScreen, newBullet)

		
	
	elseif player.bulletStrength == 3 then

		if not weaponUpdate then
			print(weaponUpdate)
			canShootTimerMax = canShootTimerMax + 0.05
			weaponUpdate = true
		end

		newBullet = { x = player.x, y = player.y - 50, img = player.bullet } 
		table.insert(activeBulletsOnScreen, newBullet)
		newBullet = { x = player.x + player.img:getWidth()/2 -5, y = player.y - 50, img = player.bullet } 
		table.insert(activeBulletsOnScreen, newBullet)
		newBullet = { x = player.x + player.img:getWidth() -10, y = player.y - 50, img = player.bullet } 
		table.insert(activeBulletsOnScreen, newBullet)


	elseif player.bulletStrength == 4 then
		
		if weaponUpdate then
			print(weaponUpdate)
			canShootTimerMax = canShootTimerMax + 0.05
			weaponUpdate = false
		end

		newBullet = { x = player.x, y = player.y - 50, img = player.bullet } 
		table.insert(activeBulletsOnScreen, newBullet)
		newBullet = { x = player.x+ 25, y = player.y - 50, img = player.bullet } 
		table.insert(activeBulletsOnScreen, newBullet)
		
		newBullet = { x = player.x + player.img:getWidth() -10, y = player.y - 50, img = player.bullet } 
		table.insert(activeBulletsOnScreen, newBullet)
		newBullet = { x = player.x + player.img:getWidth() -35, y = player.y - 50, img = player.bullet } 
		table.insert(activeBulletsOnScreen, newBullet)


	elseif player.bulletStrength == 5 then

		if not weaponUpdate then
			print(weaponUpdate)
			canShootTimerMax = canShootTimerMax + 0.05
			weaponUpdate = true
		end

		newBullet = { x = player.x, y = player.y - 50, img = player.bullet } 
		table.insert(activeBulletsOnScreen, newBullet)
		newBullet = { x = player.x+ 25, y = player.y - 50, img = player.bullet } 
		table.insert(activeBulletsOnScreen, newBullet)
		
		newBullet = { x = player.x + (player.img:getWidth()/2 - 5), y = player.y - 50, img = player.bullet } 
		table.insert(activeBulletsOnScreen, newBullet)

		newBullet = { x = player.x + player.img:getWidth() -10, y = player.y - 50, img = player.bullet } 
		table.insert(activeBulletsOnScreen, newBullet)
		newBullet = { x = player.x + player.img:getWidth() -35, y = player.y - 50, img = player.bullet } 
		table.insert(activeBulletsOnScreen, newBullet)


	elseif player.bulletStrength > 5 then
		canShootTimerMax = SHOOT_TIMER
		player.bulletStrength = 2
		player.bulletDamage = player.bulletDamage + 2
		newBullet = { x = player.x + (player.img:getWidth()/2 - 5), y = player.y - 50, img = player.bullet } 
		table.insert(activeBulletsOnScreen, newBullet)
	else 
		newBullet = { x = player.x + (player.img:getWidth()/2 - 5), y = player.y - 50, img = player.bullet } 
		table.insert(activeBulletsOnScreen, newBullet)
	end 	

	if	bulletSound:isPlaying() then
		bulletSound:stop()
	end

	bulletSound:play()
	canShootCheck = false
	canShootTimer = canShootTimerMax



end