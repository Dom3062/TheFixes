TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_set_jammed_timergui then
	-- Something will glitch out, but the game won't crash
	local set_jammed_orig = TimerGui._set_jammed
	function TimerGui:_set_jammed(jammed, ...)
		-- 565: bad argument #1 to 'floor' (number expected, got nil)
		if not jammed and not self._current_timer then
			return
		end
		
		set_jammed_orig(self, jammed, ...)
	end
end