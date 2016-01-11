function CheckCollisionOfAllEnteties( ... )

	-- If 2 enteties are coliding we are removing them
	for i, enemy in ipairs(activeEnemiesOnScreen) do
		for j, bullet in ipairs(activeBulletsOnScreen) do

			for k, enemyBullet in ipairs(activeEnemyBulletsOnScreen) do
				if CheckCollision(enemyBullet.x,enemyBullet.y,enemyBullet.img:getWidth(),enemyBullet.img:getHeight(),
								  bullet.x, bullet.y, bullet.img:getWidth(), bullet.img:getHeight()) then
					table.remove(activeBulletsOnScreen, j)
					table.remove(activeEnemyBulletsOnScreen, k)
				end
			end

			if CheckCollision(enemy.x, enemy.y, enemy.img:getWidth() , enemy.img:getHeight(), 
							  bullet.x, bullet.y, bullet.img:getWidth(), bullet.img:getHeight()) then
				if enemy.life <= 0 then
					currentEnemiesAlive = currentEnemiesAlive - 1
					table.remove(activeEnemiesOnScreen, i)

					if bonusScore then
						score = score + 2
					else
						score = score + 1
					end
				else
					enemy.life = enemy.life - player.bulletDamage
				end
				table.remove(activeBulletsOnScreen, j)
			end

			if bullet.y < 0 then
				table.remove(activeBulletsOnScreen, j)
			end
		end

		if CheckCollision(enemy.x, enemy.y, enemy.img:getWidth(), enemy.img:getHeight(),
						  player.x, player.y, player.img:getWidth(), player.img:getHeight()) 
		and (player.life > 0) then
			currentEnemiesAlive = currentEnemiesAlive - 1
			table.remove(activeEnemiesOnScreen, i)
			if player.shield then
				player.shieldDuration = player.shieldDuration - 1 
			else
				--score = score + 5
				player.life = player.life - 1
			end
		end
	end

	--
	-- coalision with enemy bullets
	for i, bullet in ipairs(activeEnemyBulletsOnScreen) do
		if CheckCollision(player.x,player.y,player.img:getWidth(), player.img:getHeight(),
						   bullet.x,bullet.y,bullet.img:getWidth(),bullet.img:getHeight()) then
			if player.shield then
				player.shieldDuration = player.shieldDuration - 1 
			else
				-- score = score + 5
				player.life = player.life - 1
			end
			table.remove(activeEnemyBulletsOnScreen,i)
		end
	end
	--

	-- updating position of powerup
	for i,powerUp in ipairs(activePowerupOnScreen) do
		powerUp.y = powerUp.y + (150*love.timer.getDelta())
		if powerUp.y > love.window.getHeight() - 40 then
			table.remove(activePowerupOnScreen,i)
		end
	end

	-- coalision of powerups
	for i,powerUp in ipairs(activePowerupOnScreen) do
		if CheckCollision(powerUp.x,powerUp.y,powerUp.img:getWidth(),powerUp.img:getHeight(),
						  player.x, player.y, player.img:getWidth(), player.img:getHeight()) 
			and isAlive then
			table.remove(activePowerupOnScreen,i)
			CheckPowerUp(powerUp.class)
			--player.life = player.life + 1
			powerUpSound:play()
		end
	end
end

-- Checks for colision of 2 Enteties
-- Returns true if two boxes overlap, false if they don't
-- x1,y1 are the left-top coords of the first box, while w1,h1 are its width and height
-- x2,y2,w2 & h2 are the same but for the second box
function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end