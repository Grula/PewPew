-- Loads images of game

function loadImages()
	imagesPowerup = {
		love.graphics.newImage('assets/Space Shooter/PNG/Power-ups/powerupGreen_bolt.png'),
		love.graphics.newImage('assets/Space Shooter/PNG/Power-ups/powerupBlue_star.png'),
		love.graphics.newImage('assets/Space Shooter/PNG/Power-ups/powerupRed_shield.png'),
		love.graphics.newImage('assets/Space Shooter/PNG/Power-ups/things_gold.png')}
	---------------------------------------------------------------------------------
	backgroundImges = {
		love.graphics.newImage('assets/Space Shooter/Backgrounds/blue.png'),
		love.graphics.newImage('assets/Space Shooter/Backgrounds/purple.png'),
		love.graphics.newImage('assets/Space Shooter/Backgrounds/darkPurple.png'),
	}
	enemyImges = {
		love.graphics.newImage('assets/Space Shooter/PNG/Enemies/enemyGreen1.png'),
		love.graphics.newImage('assets/Space Shooter/PNG/Enemies/enemyBlack1.png'),
		love.graphics.newImage('assets/Space Shooter/PNG/Enemies/enemyRed1.png')
		}

	-- Blue,Red,Green
	imagesPlayerBasic = {
		love.graphics.newImage('assets/Space Shooter/PNG/playerShip1_blue.png'),
		love.graphics.newImage('assets/Space Shooter/PNG/playerShip1_red.png'),
		love.graphics.newImage('assets/Space Shooter/PNG/playerShip1_green.png')
	}
	imagesBulletBasic = {
		love.graphics.newImage('assets/Space Shooter/PNG/Lasers/laserBlue01.png'),
		love.graphics.newImage('assets/Space Shooter/PNG/Lasers/laserRed01.png'),
		love.graphics.newImage('assets/Space Shooter/PNG/Lasers/laserGreen11.png')
	}
	--print(Highscore)
	--C:\Users\grula\Desktop\Uni\Projects\LUA\projects\Pew Pew\assets\Space Shooter\PNG
	enemyImg = enemyImges[1] 
    player.img = imagesPlayerBasic[2]
    player.bullet = imagesBulletBasic[2]
    backgroundImg = love.graphics.newImage('assets/Space Shooter/Backgrounds/blue.png')
    return true
end