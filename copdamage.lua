TheFixesPreventer = TheFixesPreventer or {}
-- Fix for 'Masterpiece' achievement
-- Fix for 'Matrix with lasers' achievement
local origfunc = CopDamage._on_damage_received
function CopDamage:_on_damage_received(damage_info, ...)
	if damage_info.result.type == 'death' then
		if not TheFixesPreventer.achi_masterpiece then
			AchievmentManager.the_fixes_failed = AchievmentManager.the_fixes_failed or {}
			AchievmentManager.the_fixes_failed['cac_19'] = true
		end
		
		if not TheFixesPreventer.achi_matrix_with_lasers then
			local char_tweak = tweak_data.character[self._unit:base()._tweak_table or '']
			if char_tweak
				and char_tweak.priority_shout
				and char_tweak.priority_shout == 'f34'
			then
				AchievmentManager.the_fixes_failed = AchievmentManager.the_fixes_failed or {}
				AchievmentManager.the_fixes_failed['cac_22'] = true
			end
		end
	end
	return origfunc(self, damage_info, ...)
end


if not TheFixesPreventer.crits_in_stealth then
	-- Fix for crits in stealth
	local roll_crit_orig = CopDamage.roll_critical_hit
	function CopDamage:roll_critical_hit(attack_data, ...)
		if self._unit:movement():cool() then
			attack_data.damage = self._HEALTH_INIT
		end
		
		return roll_crit_orig(self, attack_data, ...)
	end
end