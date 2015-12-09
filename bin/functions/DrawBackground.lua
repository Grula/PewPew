function drawBackground()
i = 0
	while i <= love.window.getHeight() do
		j = 0
		while j <= love.window.getWidth() do
			love.graphics.draw(backgroundImg,j,i)
			j = j + backgroundImg:getWidth()		
		end
		i = i + backgroundImg:getHeight()
	end
end

