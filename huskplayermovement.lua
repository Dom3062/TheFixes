-- This should fix the crash with custom magazines
local origfunc = HuskPlayerMovement.anim_clbk_spawn_dropped_magazine
function HuskPlayerMovement:anim_clbk_spawn_dropped_magazine(...)
	if self._magazine_data then
		origfunc(self, ...)
	end
end

-- self._vehicle=nil crash fix
local origfunc = HuskPlayerMovement._upd_attention_driving
function HuskPlayerMovement:_upd_attention_driving(...)
	if self._vehicle then
		origfunc(self, ...)
	end
end