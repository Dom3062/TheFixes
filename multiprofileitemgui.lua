-- Fix for infinite sound loop when pointing between the right arrow and the 'list' button
local lx = 0
local ly = 0
local origfunc = MultiProfileItemGui.mouse_moved
function MultiProfileItemGui:mouse_moved(x, y, ...)
	if lx ~= x and ly ~= y then
		origfunc(self, x, y, ...)
		lx = x
		ly = y
	end
end