DEBUG = false

local clickables = {}
local font = love.graphics.getFont()
local time = 0.0


function love.load()
	Object = require "lib.classic"
	require "elements"

	for i=1,100 do	
		local c = Clickable(
			love.graphics.newImage("demo/assets/button.png"),
			love.math.random(0, love.graphics.getWidth()),
			love.math.random(0, love.graphics.getHeight()),
			0
		)

		table.insert(clickables, c)
	end
end


function love.update(dt)
	for _, clickable in pairs(clickables) do
		clickable:update(dt)
	end
end


function love.draw()
	for _, clickable in pairs(clickables) do
		clickable:draw()
	end
	
	love.graphics.print(tostring(love.timer.getFPS()), 10, 10)
end
