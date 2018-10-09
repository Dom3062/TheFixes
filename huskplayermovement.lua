-- This should fix the crash with custom magazines
local origfunc = HuskPlayerMovement.anim_clbk_spawn_dropped_magazine
function HuskPlayerMovement:anim_clbk_spawn_dropped_magazine(...)
	if self._magazine_data then
		origfunc(self, ...)
	end
end