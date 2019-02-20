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