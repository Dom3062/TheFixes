-- Fire DOT stats fix
-- Fix for 'Masterpiece' achievement
-- Fix for 'Matrix with lasers' achievement
local origfunc = CopDamage._on_damage_received
function CopDamage:_on_damage_received(damage_info, ...)
	if damage_info.result.type == 'death' then
		if damage_info.is_fire_dot_damage
			and (not TheFixes or TheFixes.fire_dot)
		then
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
		
		local char_tweak = tweak_data.character[self._unit:base()._tweak_table or '']
		if char_tweak
			and char_tweak.priority_shout
			and char_tweak.priority_shout == 'f34'
		then
			AchievmentManager.the_fixes_failed['cac_22'] = true
		end
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


-- Fix for crits in stealth
local roll_crit_orig = CopDamage.roll_critical_hit
function CopDamage:roll_critical_hit(attack_data, ...)
	if self._unit:movement():cool() then
		attack_data.damage = self._HEALTH_INIT
	end
	
	return roll_crit_orig(self, attack_data, ...)
end


local sync_dmg_expl_orig = CopDamage.sync_damage_explosion
function CopDamage:sync_damage_explosion(attacker_unit, damage_percent, ...)
	local damage = damage_percent * self._HEALTH_INIT_PRECENT
	damage, damage_percent = self:_apply_min_health_limit(damage, damage_percent)

	return sync_dmg_expl_orig(self, attacker_unit, damage_percent, ...)
end