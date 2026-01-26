Draggable = Object:extend()
require "utils"
require "data"

local scaleHover = 1.2
local scaleDrag = 0.9
local tiltThreshold = 0.5
local tiltDamp = 30.0 -- mouse relative x pixels per frame / this value


function Draggable:new(drawable, x, y, margin)
	self.dragging = false
	self.drawable = drawable
	self.x = x
	self.y = y
	self.prevMouseX = 0.0
	self.prevMouseY = 0.0
	self.w = drawable:getWidth() + margin
	self.h = drawable:getHeight() + margin
	self.r = 0.0
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


function Draggable:update(dt)
	local mouseX = love.mouse.getX()
	local mouseY = love.mouse.getY()
	
	if self.dragging and not love.mouse.isDown(1) then
		self.dragging = false
		D.elementSelected = false
	end

	if self.dragging then
		self.x = mouseX 
		self.y = mouseY
	
		self.sxd = scaleDrag
		self.syd = scaleDrag
		-- todo
		self.r = lerp(self.r, getTilt(mouseX, self.prevMouseX), 0.5)

	elseif isMouseOnElement(self.x, self.y, self.w, self.h) then
		if love.mouse.isDown(1) and not D.elementSelected then
			self.dragging = true
			D.elementSelected = true	
		else
			self.sxd = scaleHover
			self.syd = scaleHover
		end
	else
		self.sxd = 1.0
		self.syd = 1.0
		self.r = 0.0
	end

	self.sx, self.vx = spring(self.sx, self.vx, self.sxd, 0.2, 0.5)
	self.sy, self.vy = spring(self.sy, self.vy, self.syd, 0.2, 0.2)

	self.prevMouseX = mouseX	
	self.prevMouseY = mouseY	
end


function Draggable:draw()
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


function getTilt(x, prevX)
	local relX = x - prevX
	if math.abs(relX) >= tiltThreshold then
		return(relX / tiltDamp)
	end		
	
	return(0.0)
end	




