-- Prevent the crash on Birth of Sky
local origfunc = GroupAIStateBesiege._check_phalanx_group_has_spawned
function GroupAIStateBesiege:_check_phalanx_group_has_spawned(...)
	if self._phalanx_spawn_group
		and self._phalanx_spawn_group.has_spawned
		and not self._phalanx_spawn_group.set_to_phalanx_group_obj
	then
		for i, group_unit in pairs(self._phalanx_spawn_group.units) do
			if not (group_unit.unit and group_unit.unit:base()) then
				self._phalanx_spawn_group.units[i] = nil
			end
		end
	end
	origfunc(self, ...)
end