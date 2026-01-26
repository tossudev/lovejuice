DEBUG = false
Font = love.graphics.newFont("demo/assets/font.ttf", 32)

local windowWidth, windowHeight = love.window.getDesktopDimensions()
windowWidth, windowHeight = windowWidth*.85, windowHeight*.85 --make the window a bit smaller than the screen itself

local elements = {}
local t = {}
local bg = love.graphics.newImage("demo/assets/background.png")
local time = 0.0


function love.load()
	Object = require "lib.classic"
	require "elements.clickable"
	require "elements.draggable"
	require "elements.text"
	require "data"	
	Data()

	love.window.setMode(windowWidth, windowHeight)

	for i=1,8 do	
		local c = Draggable(
			love.graphics.newImage("demo/assets/button.png"),
			i * 128.0,
			128.0,
			0
		)
		table.insert(elements, c)
	end

	t = Text(
		{{0, 0, 0}, "hello lovely text! :)"},
		windowWidth/2,
		256
	)
	table.insert(elements, t)
end


function love.update(dt)
	for _, element in pairs(elements) do
		element:update(dt)
	end
end


function love.draw()
	love.graphics.draw(
		bg,
		0, 0, 0,
		windowWidth/bg:getWidth(),
		windowHeight/bg:getHeight()
	)

	for _, element in pairs(elements) do
		element:draw()
	end
	
	love.graphics.print(tostring(love.timer.getFPS()), 10, 10)
end


function love.keypressed(key, scancode, isrepeat)
	if key == "return" then
		t:updateText({{0, 0, 0}, "hello even lovelier world! :D"})
	end
end





