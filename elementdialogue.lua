TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.mute_contractor_fixes then
	-- This allows us to force any dialog to be played
	local levels = {
		dah = {
				[103883] = true,
				[103884] = true,
				[103882] = true
			},
		nail = {
				[100120] = true,
				[100123] = true,
				[100135] = true,
				[100136] = true,
				[100137] = true,
				[100138] = true,
				[100139] = true,
				[100144] = true,
				[100163] = true
			}
	}
	local current_level
	local origfunc = ElementDialogue._can_play
	function ElementDialogue:_can_play(...)
		local res = origfunc(self, ...)

		if not res then
			if not current_level then
				current_level = managers.job:current_level_id() or ''
			end
			
			if levels[current_level]
				and levels[current_level][self._id or 0]
			then
				return true
			end
		end
		
		return res
	end
end