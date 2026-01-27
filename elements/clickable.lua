Clickable = Object:extend()
require "utils"

local scaleHover = 1.2
local scalePressed = 0.8
local rotationHover = 10.0/57.29 --degrees to radians


function Clickable:new(drawable, x, y, margin)
	self.drawable = drawable
	self.x = x
	self.y = y
	self.w = drawable:getWidth() + margin
	self.h = drawable:getHeight() + margin
	self.r = 0.0 -- rotation
	self.rd = 0.0
	self.ox = self.w/2 --origin offset (center of drawable)
	self.oy = self.h/2
	self.sx = 1.0 --scale
	self.sy = 1.0
	self.sxd = 1.0 --scale destination
	self.syd = 1.0
	self.vx = 0.0 --spring velocity
	self.vy = 0.0
	self.vr = 0.0
end


function Clickable:update(dt)
	if isMouseOnElement(self) then
		if love.mouse.isDown(1) then
			self.sxd = scalePressed
			self.syd = scalePressed
			self.rd = 0.0
		else
			self.sxd = scaleHover
			self.syd = scaleHover
			self.rd = rotationHover
		end

	else
		self.sxd = 1.0
		self.syd = 1.0
		self.rd = 0.0
	end

	-- keep	rigidness for x&y scales different for that jiggly feel
	self.sx, self.vx = spring(self.sx, self.vx, self.sxd, 0.2, 0.4)
	self.sy, self.vy = spring(self.sy, self.vy, self.syd, 0.2, 0.2)
	self.r, self.vr = spring(self.r, self.vr, self.rd, 0.5)
end


function Clickable:draw()
	love.graphics.draw(
		self.drawable,
		self.x,
		self.y,
		self.r, --rotation
		self.sx,
		self.sy,
		self.ox,
		self.oy
	)

	-- debug bounding box
	if DEBUG then		
		love.graphics.rectangle(
			"line",
			self.x - self.w/2,
			self.y - self.h/2,
			self.w,
			self.h
		)
	end
end
