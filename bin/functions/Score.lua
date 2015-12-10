function CheckScore()
	if scoreUpdate then
		SCORE = score
		-- Updateing highscore
		if SCORE > Highscore then
			newHighScoreSound:play()
			Highscore = SCORE
			if WriteHighscore(SCORE) then
				print("Highscore sucsesfully written")
			end
		end
		scoreUpdate = false
	end
end
-- We save current score if player dies so score freezes
-- Also if score is higher then a highscore we update
-- highscore