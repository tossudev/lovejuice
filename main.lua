DEBUG = false

local windowWidth, windowHeight = love.window.getDesktopDimensions()
windowWidth, windowHeight = windowWidth*.85, windowHeight*.85 --make the window a bit smaller than the screen itself

local clickables = {}
local bg = love.graphics.newImage("demo/assets/background.png")
local font = love.graphics.getFont()
local time = 0.0


function love.load()
	Object = require "lib.classic"
	require "elements.clickable"
	require "elements.draggable"
	require "data"	
	Data()

	love.window.setMode(windowWidth, windowHeight)

	for i=1,100 do	
		local c = Draggable(
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
	love.graphics.draw(
		bg,
		0, 0, 0,
		windowWidth/bg:getWidth(),
		windowHeight/bg:getHeight()
	)

	for _, clickable in pairs(clickables) do
		clickable:draw()
	end
	
	love.graphics.print(tostring(love.timer.getFPS()), 10, 10)
end
