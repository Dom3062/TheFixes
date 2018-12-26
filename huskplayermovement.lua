-- This should fix the crash with custom magazines
local origfunc = HuskPlayerMovement.anim_clbk_spawn_dropped_magazine
function HuskPlayerMovement:anim_clbk_spawn_dropped_magazine(...)
	if self._magazine_data then
		origfunc(self, ...)
	end
end

-- self._vehicle=nil crash fix
local origfunc2 = HuskPlayerMovement._upd_attention_driving
function HuskPlayerMovement:_upd_attention_driving(...)
	if self._vehicle then
		origfunc2(self, ...)
	end
end


local sync_melee_orig = HuskPlayerMovement.sync_melee_start
function HuskPlayerMovement:sync_melee_start(hand, ...)
	sync_melee_orig(self, hand or 0, ...)
end