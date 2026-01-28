DEBUG = false
Font = love.graphics.newFont("demo/assets/font.ttf", 32)

local push = require "lib.push"
local gameWidth, gameHeight = 1920, 1080 -- fixed game resolution
local windowWidth, windowHeight = love.window.getDesktopDimensions()
windowWidth = windowWidth*0.8
windowHeight= windowHeight*0.8

push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = false, resizable = true})

local elements = {}
local t = {}
local bIncrement = {}
local bDecrement = {}
local bg = love.graphics.newImage("demo/assets/background.png")
local time = 0.0
local textValue = 100
local textValueIncrement = 100


function love.load()
	Object = require "lib.classic"
	require "elements.clickable"
	require "elements.draggable"
	require "elements.text"
	require "data"	
	require "utils"
	Data()

	love.window.setTitle("lovejuice")

	bDecrement = Clickable(
		love.graphics.newImage("demo/assets/button_arrow_l.png"),
		128,
		128,
		0
	)
	bIncrement = Clickable(
		love.graphics.newImage("demo/assets/button_arrow_r.png"),
		128 + 80,
		128,
		0
	)
	table.insert(elements, bDecrement)
	table.insert(elements, bIncrement)

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
	push:start()
	love.graphics.draw(bg)

	for _, element in pairs(elements) do
		element:draw()
	end
	
	love.graphics.print(tostring(love.timer.getFPS()), 10, 10)
	push:finish()
end


function love.resize(w, h)
	return push:resize(w, h)
end


function love.keypressed(key, scancode, isrepeat)
	if key == "return" then
		t:updateText({{0, 0, 0}, "hello even lovelier world! :D"})
	end
	if key == "f" then
		push:switchFullscreen()
	end
end


function love.mousepressed(_x, _y, button)
	if button ~= 1 then
		return
	end

	if isMouseOnElement(bDecrement) then
		textValue = textValue - textValueIncrement
		t:updateText({{0, 0, 0}, tostring(textValue)})
	end
	if isMouseOnElement(bIncrement) then
		textValue = textValue + textValueIncrement
		t:updateText({{0, 0, 0}, tostring(textValue)})
	end
	
end



