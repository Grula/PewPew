function CheckScore()
	if scoreUpdate then
		SCORE = score
		-- Updateing highscore
		if SCORE > highscore then
			newHighScoreSound:play()
			highscore = SCORE
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


-- SCORE ------------------------------------------------------------------
-- needs fixing
function WriteHighscore( score )
	--bin/highscore/
	local file =assert(io.open("bin\\highscore\\highscore.txt","w"),"Error while opening file :(")
	file:write(score)
	file:close()
	return true
end	


function LoadHighscore()
	--C:/Users/grula/Desktop/Uni/Projects/LUA/projects/Pew Pew/
	local file =assert(io.open("C:/Users/grula/Desktop/Uni/Projects/LUA/projects/Pew Pew/bin/highscore/highscore.txt","r"),"Error while opening file :(")
	local line = file:read()
	file:close()
	if line ~= nil then
		return tonumber(line)
	else
		return 0
	end
end
-----------------------------------------------------------------------
