TheFixesPreventer = TheFixesPreventer or {}
local sync_melee_orig = HuskPlayerMovement.sync_melee_start
function HuskPlayerMovement:sync_melee_start(hand, ...)
	if not TheFixesPreventer.crash_upd_att_drive_huskplayermov then
		hand = hand or 0
	end
	
	if not TheFixesPreventer.crash_vr_melee_huskplayermov then
		local anim_enabled_old = self._arm_animation_enabled
		self._arm_animation_enabled = false
		sync_melee_orig(self, hand, ...)
		self._arm_animation_enabled = anim_enabled_old
	else
		sync_melee_orig(self, hand, ...)
	end
end

if not TheFixesPreventer.crash_eq_weap_td_huskplayermov then
	local eq_weap_td_orig = HuskPlayerMovement._equipped_weapon_tweak_data
	function HuskPlayerMovement:_equipped_weapon_tweak_data(...)
		local res = eq_weap_td_orig(self, ...)
		if res then
			res.timers = res.timers or {}
			res.timers.equip = res.timers.equip or 0.5
			res.timers.unequip = res.timers.unequip or 0.5
		end
		return res
	end
end

if not TheFixesPreventer.crash_spawn_magazine_unit_huskplayermov then
	-- huskplayermovement.lua"]:3906: attempt to index local 'equipped_weapon' (a nil value)
	local spawn_magazine_unit_orig = HuskPlayerMovement._spawn_magazine_unit
	function HuskPlayerMovement:_spawn_magazine_unit(part_id, unit_name, pos, rot, ...)
		if self._unit:inventory():equipped_unit() then
			return spawn_magazine_unit_orig(self, part_id, unit_name, pos, rot, ...)
		end
		return World:spawn_unit(unit_name, pos, rot)
	end
end
