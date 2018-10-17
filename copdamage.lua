-- Fire DOT stats fix
-- Fix for 'Masterpiece' achievement
local origfunc = CopDamage._on_damage_received
function CopDamage:_on_damage_received(damage_info, ...)
	if damage_info.result.type == 'death' then
		if damage_info.is_fire_dot_damage then
			local data = {
				name = self._unit:base()._tweak_table,
				stats_name = self._unit:base()._stats_name,
				head_shot = false,
				weapon_unit = damage_info.weapon_unit,
				variant = damage_info.variant
			}
			managers.statistics:killed(data)
		end
		
		AchievmentManager.the_fixes_failed = AchievmentManager.the_fixes_failed or {}
		AchievmentManager.the_fixes_failed['cac_19'] = true
	end
	return origfunc(self, damage_info, ...)
end


-- Fix for concussion grenade stunning dominated and traded cops
local origfunc4 = CopDamage.stun_hit
function CopDamage:stun_hit(...)
	local brain = self._unit:brain()
	if brain
		and (brain:is_current_logic('intimidated')
			or brain:is_current_logic('trade'))
	then
		return
	end
	
	origfunc4(self, ...)
end