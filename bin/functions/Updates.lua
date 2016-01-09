-- Timer to be able to shoot -------------------------------------------------------------------------------------------------------------
function ChecksShootTimer( dt )
	canShootTimer = canShootTimer - (1 * dt)
	if canShootTimer < 0 then
	  canShootCheck = true
	end
end


-- DESTROY/CREATE enteties -------------------------------------------------------------------------------------------------------------------------------

function CheckBullets(dt)
	for i, bullet in ipairs(activeBulletsOnScreen) do
		bullet.y = bullet.y - (350 * dt)
	  	-- remove activeBulletsOnScreen when they pass off the screen	
	  	if bullet.y < 0 then 
			table.remove(activeBulletsOnScreen, i)
		end
	end
end

function CheckEnemyBullets(dt)
    --PROVERITI
	for i,bullet in ipairs(activeEnemyBulletsOnScreen) do
		bullet.y = bullet.y + (enemySpeed*2*dt)
		if bullet.y < 0 then 
			table.remove(activeEnemyBulletsOnScreen,i)
		end
	end
end

function EnemyShoot( ... )
	for i, enemy in ipairs(activeEnemiesOnScreen) do
		local randomNumb = math.random(1,1000)
		if randomNumb == 1 or randomNumb == 500 then
			newBullet = { x = enemy.x + (enemy.img:getWidth()/2 -20),
					  y = enemy.y + 90,
					  img = enemyBullet } 
			table.insert(activeEnemyBulletsOnScreen, newBullet)
		end
	end
end

function UpdateShield( dt )
	if player.shieldDuration > 0 then
		player.shieldDuration = player.shieldDuration - (1*dt)
	else
		player.shield = false
	end
end

function UpdateBonusScore( dt )
	if bonusScore then
		bonusScoreDuration = bonusScoreDuration - 1*dt
		if bonusScoreDuration <= 0 then
			bonusScore =false
		end
	end
end

function UpdateVisualLasers( ... )
	if player.bulletDamage*2 > currentPlayerBulletDamage then
		currentPlayerBulletDamage = currentPlayerBulletDamage + 2
		player.bullet = imagesBulletBasic[math.mod(currentPlayerBulletDamage-1,table.getn(imagesBulletBasic))+1]

	end
end
