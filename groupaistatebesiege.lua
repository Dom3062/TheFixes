TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_winters_bos_aistatebesiege then
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
end


-- Fix for the bug when there is too many dozers
local fixed = false
local origfunc2 = GroupAIStateBesiege._get_special_unit_type_count
function GroupAIStateBesiege:_get_special_unit_type_count(special_type, ...)
	if special_type == 'tank_mini' or special_type == 'tank_medic' then
		fixed = true
	end
	
	if not fixed and special_type == 'tank'
		and (not TheFixes or TheFixes.dozers_counting)
	then
		local res = origfunc2(self, 'tank', ...) or 0
		res = res + (origfunc2(self, 'tank_mini', ...) or 0)
		res = res + (origfunc2(self, 'tank_medic', ...) or 0)
		return res
	end
	
	return origfunc2(self, special_type, ...)
end

TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_no_unit_type_aistatebesiege then
	local perf_gr_spwn_orig = GroupAIStateBesiege._perform_group_spawning
	function GroupAIStateBesiege:_perform_group_spawning(spawn_task, ...)
		for u_type_name, spawn_info in pairs(spawn_task.units_remaining) do
			local category = tweak_data.group_ai.unit_categories[u_type_name]
			if category and category.unit_types then
				local u = category.unit_types[tweak_data.levels:get_ai_group_type()]
				if not u then
					spawn_task.units_remaining[u_type_name] = nil
				end
			else
				spawn_task.units_remaining[u_type_name] = nil
			end
		end
		
		return perf_gr_spwn_orig(self, spawn_task, ...)
	end
end


