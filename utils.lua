local rigidness = 0.2
local damping = 0.2

function spring(value, velocity, dest)
	local distance_to_dest = value - dest
    local loss = damping * velocity

    -- hooke's law
    local force = -rigidness * distance_to_dest - loss

    velocity = velocity + force
    value = value + velocity

	return value, velocity
end


function isMouseOnElement(x, y, w, h)
    -- returns scaled pixels
    local mousePosX, mousePosY = love.mouse.getX(), love.mouse.getY()

    local offset_x = (x - (w/2.0))
    local offset_y = (y - (h/2.0))

    return mousePosX >= offset_x
    and mousePosX < offset_x + w
    and mousePosY >= offset_y
    and mousePosY < offset_y + h
end
