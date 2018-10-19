-- Prevent the crash on Birth of Sky
local origfunc = GroupAIStateBesiege._check_phalanx_group_has_spawned
function GroupAIStateBesiege:_check_phalanx_group_has_spawned(...)
	if self._phalanx_spawn_group
		and self._phalanx_spawn_group.has_spawned
		and not self._phalanx_spawn_group.set_to_phalanx_group_obj
	then
		for i, group_unit in pairs(self._phalanx_spawn_group.units) do
			if not group_unit.unit then
				self._phalanx_spawn_group.units[i] = nil
			end
		end
	end
	origfunc(self, ...)
end


-- Fix for the bug when there is too many dozers
local fixed = false
local origfunc2 = GroupAIStateBesiege._get_special_unit_type_count
function GroupAIStateBesiege:_get_special_unit_type_count(special_type, ...)
	if special_type == 'tank_mini' or special_type == 'tank_medic' then
		fixed = true
	end
	
	if not fixed and special_type == 'tank' then
		local res = origfunc2(self, 'tank', ...) or 0
		res = res + (origfunc2(self, 'tank_mini', ...) or 0)
		res = res + (origfunc2(self, 'tank_medic', ...) or 0)
		return res
	end
	
	return origfunc2(self, special_type, ...)
end