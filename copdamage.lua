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