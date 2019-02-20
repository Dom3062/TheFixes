TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.sound_loop_multiprofileitem then
	-- Fix for infinite sound loop when pointing between the right arrow and the 'list' button
	local lx = 0
	local ly = 0
	local res = {}
	local origfunc = MultiProfileItemGui.mouse_moved
	function MultiProfileItemGui:mouse_moved(x, y, ...)
		if lx ~= x and ly ~= y then
			lx = x
			ly = y
			res[1], res[2] = origfunc(self, x, y, ...)
		end
		return res[1], res[2]
	end

	local pressed_orig = MultiProfileItemGui.mouse_pressed
	function MultiProfileItemGui:mouse_pressed(button, x, y, ...)
		lx = 0
		ly = 0
		return pressed_orig(self, button, x, y, ...)
	end
end