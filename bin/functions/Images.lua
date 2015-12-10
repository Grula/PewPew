-- Loads images of game

function loadImages()
	powerUpsImg = {
		love.graphics.newImage('assets/Space Shooter/PNG/Power-ups/powerupGreen_bolt.png'),
		love.graphics.newImage('assets/Space Shooter/PNG/Power-ups/powerupBlue_star.png'),
		love.graphics.newImage('assets/Space Shooter/PNG/Power-ups/powerupRed_shield.png'),
		love.graphics.newImage('assets/Space Shooter/PNG/Power-ups/things_gold.png')}
	---------------------------------------------------------------------------------

	--print(Highscore)
	--C:\Users\grula\Desktop\Uni\Projects\LUA\projects\Pew Pew\assets\Space Shooter\PNG
	enemyImg = love.graphics.newImage('assets/Space Shooter/PNG/Enemies/enemyGreen1.png')
    player.img = love.graphics.newImage('assets/Space Shooter/PNG/playerShip1_blue.png')
    bulletImg = love.graphics.newImage('assets/Space Shooter/PNG/Lasers/laserBlue01.png')
    backgroundImg = love.graphics.newImage('assets/Space Shooter/Backgrounds/blue.png')
    return true
end