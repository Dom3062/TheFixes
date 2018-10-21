-- Fire DOT stats fix
-- Fix for 'Masterpiece' achievement
-- Fix for 'Matrix with lasers' achievement
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


-- Make shotgun pellets prioritize dozer's faceplate and visor
local origfunc2 = CopDamage.is_head
function CopDamage:is_head(body, ...)
	local head = origfunc2(self, body, ...) or false
	
	if not head and body then
		local bn = tostring(body:name()) --Idstring(@xxxxxxxxxxxxxxxxxx@)
		local di = (debug.getinfo(3, 'Sn') or {})
		if di.name and di.name == '_fire_raycast'
			and di.source and di.source:match('shotgunbase%.lua')
			and (bn:match('IDf46eb16d189339da')
				or bn:match('IDf260d73afd0c74fe'))
		then
			head = true
		end
	end
	
	return head
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