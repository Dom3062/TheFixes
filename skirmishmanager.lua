TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.holdout_rewards_clients_2 then
	local host_match_orig = SkirmishManager.host_weekly_match
	function SkirmishManager:host_weekly_match(...)
		local res = host_match_orig(self, ...)
		
		-- The only thing that can be different is the modifiers list
		if not res and self:active_weekly() and self:is_weekly_skirmish() then
			local host_mod_str = managers.network.matchmake.lobby_handler:get_lobby_data("skirmish_weekly_modifiers")

			if self._global.active_weekly.modifiers_str and host_mod_str == self._global.active_weekly.modifiers_str then
				return true
			end
		end
		
		return res
	end

	local act_weekly_orig = SkirmishManager.activate_weekly_skirmish
	function SkirmishManager:activate_weekly_skirmish(weekly_skirmish_string, ...)
		act_weekly_orig(self, weekly_skirmish_string, ...)
		
		self._global.active_weekly.modifiers_str = string.split(weekly_skirmish_string, ";")[3] or 'null'
	end
end