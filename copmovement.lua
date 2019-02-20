TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_custom_mags_copmovement then
	-- This should fix the crash with custom magazines
	local origfunc = CopMovement.anim_clbk_spawn_dropped_magazine
	function CopMovement:anim_clbk_spawn_dropped_magazine(...)
		if self._magazine_data then
			origfunc(self, ...)
		end
	end
end