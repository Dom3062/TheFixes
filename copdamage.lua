-- Fire DOT stats fix
local origfunc = CopDamage._on_damage_received
function CopDamage:_on_damage_received(damage_info, ...)
	if damage_info.is_fire_dot_damage
		and damage_info.result.type == 'death'
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