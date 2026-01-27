Text = Object:extend()
require "utils"

local scaleChange = 1.5
local rotationLimit = 15.0 --random rotation value maximum (in degrees)


function Text:new(text, x, y)
	self.text = love.graphics.newText(Font, text)
	self.x = x
	self.y = y
	self.r = 0.0

	self:updateWH()	
	self.sx = 1.0
	self.sy = 1.0

	self.sxd = 1.0
	self.syd = 1.0
	self.rd = 0.0
	self.vx = 1.0
	self.vy = 1.0
	self.vr = 1.0
end


function Text:update(dt)
	self.sxd = lerp(self.sxd, 1.0, 0.5)
	self.syd = lerp(self.syd, 1.0, 0.5)
	self.rd = lerp(self.rd, 0.0, 0.2)
	
	self.sx, self.vx = spring(self.sx, self.vx, self.sxd, 0.2, 0.5)
	self.sy, self.vy = spring(self.sy, self.vy, self.syd, 0.2, 0.2)
	self.r = self.rd
end


function Text:draw()
	love.graphics.draw(
		self.text,
		self.x,
		self.y,
		self.r,
		self.sx,
		self.sy,
		self.ox,
		self.oy	
	)
end


function Text:updateWH()
    self.w = self.text:getWidth()
    self.h = self.text:getHeight()
	self.ox = self.w/2
    self.oy = self.h/2
end


function Text:updateText(newText)
	self.text:setf(newText, 10000, "left")
	self.sxd = scaleChange
	self.syd = scaleChange
	self.rd = math.random(-rotationLimit, rotationLimit)
	self.rd = self.rd/57.29 --deg to rad

	self:updateWH()
end


