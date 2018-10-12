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


-- Sync 'Say Hello to My Big Friend' achievement
local origfunc3 = CopDamage._check_friend_4
function CopDamage:_check_friend_4(attack_data, ...)
	origfunc3(self, attack_data, ...)
	local tt = self._unit:base()._tweak_table
	if tt == 'drug_lord_boss' or tt == 'drug_lord_boss_stealth' then
		self._unit:network():send('sync_friend_4', self._unit, attack_data)
	end
end