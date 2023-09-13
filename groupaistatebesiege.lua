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


