-- Loads audio

function loadAudio()
	gameSounds = {	'assets/sound/Music/Retro Mystic.ogg',
					'assets/sound/Music/Retro Beat.ogg',
					'assets/sound/Music/Retro Reggae.ogg' }

	powerUpSound = love.audio.newSource('assets/sound/powerUp7.ogg')
	
	pewPewGameSound = love.audio.newSource(gameSounds[1])
	pewPewGameSound:setLooping()
	pewPewGameSound:setVolume(0.5)

	bulletSound = love.audio.newSource('assets/sound/laser4.ogg')
	bulletSound:setVolume(1)
	
	gameOverSound = love.audio.newSource( 'assets/sound/game_over.ogg' )
	gameOverSound:setVolume(0.6)
	
	newHighScoreSound = love.audio.newSource('assets/sound/new_highscore.ogg')
	newHighScoreSound:setVolume(0.6)
	return true
end