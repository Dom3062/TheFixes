TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.holdout_rewards_clients then
	-- Fix for houldout not rewarding clients who were in the lobby before the host switched to holdout
	local origfunc = SkirmishManager.init_finalize
	function SkirmishManager:init_finalize(...)
		local lobby_data = managers.network.matchmake:get_lobby_data() or {}
		Global.game_settings.weekly_skirmish = (tonumber(lobby_data.skirmish or '') or 0) == (SkirmishManager.LOBBY_WEEKLY or 10)
		
		origfunc(self, ...)
	end
end

if not TheFixesPreventer.holdout_rewards_clients_2 then
	local host_match_orig = SkirmishManager.host_weekly_match
	function SkirmishManager:host_weekly_match(...)
		local res = host_match_orig(self, ...)
		
		-- The only thing that can be different is the modifiers list
		if not res and self:active_weekly() and self:is_weekly_skirmish() then
			local host_mod_str = managers.network.matchmake.lobby_handler:get_lobby_data("skirmish_weekly_modifiers")

			if host_mod_str == self._global.active_weekly.modifiers_str then
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