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


-- SCORE writing and loading ------------------------------------------------------------------
function WriteHighscore( score )
	if love.filesystem.isFused() then
	    local dir = love.filesystem.getSourceBaseDirectory()
	    local success = love.filesystem.mount(dir, "Pew Pew")
	    if success then
	       	local file = io.open("/bin/highscore/highscore.txt","w")
	       	if file ~= nil then
		       	file:write(score)
				file:close()
				return true
			else
				ok = love.filesystem.createDirectory("bin")
				if ok then
					ok = love.filesystem.createDirectory("/bin/highscore")
					if ok then
						file = love.filesystem.newFile("/bin/highscore/highscore.txt")
						file:open('w')
						if file~=nil then
							file:write(score)
							file:close()
							return true
						end
					end
				end
			end	
	    end
	    return false
	else
		local path = love.filesystem.getSourceBaseDirectory()
		local file = io.open(path.."/Pew Pew/bin/highscore/highscore.txt","w")
		if (file:write(score)) then
			file:close()
			return true
		else
			return false
		end
	end
end	


function LoadHighscore()
	if love.filesystem.isFused() then
	    local dir = love.filesystem.getSourceBaseDirectory()
	    local success = love.filesystem.mount(dir, "Pew Pew")
	    if success then
	    	local file =io.open("/bin/highscore/highscore.txt","r")
			if file ~= nil then
				local line = file:read()
				file:close()
				if line ~= nil then
					return tonumber(line)
				else
					return 0
				end
			else
				return 0
			end
	    end
	else
		local path = love.filesystem.getSourceBaseDirectory()
		local file = io.open(path.."/Pew Pew/bin/highscore/highscore.txt","r")
		if file ~= nil then
			local line = file:read()
			file:close()
			if line ~= nil then
				return tonumber(line)
			else
				return 0
			end
		end
		return -1
	end
end
-----------------------------------------------------------------------
