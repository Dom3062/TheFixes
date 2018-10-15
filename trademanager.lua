-- Stoic auto-negate damage after custody not working fix
local origfunc = TradeManager.criminal_respawn
function TradeManager:criminal_respawn(...)
	origfunc(self, ...)
	
	if managers.player:has_category_upgrade("player", "damage_control_auto_shrug")
		and managers.player:upgrade_value("player", "damage_control_auto_shrug")
		and managers.player._coroutine_mgr
	then
		if not managers.player._coroutine_mgr:is_running('damage_control') then
		----------------------------------------------------------------------
			local function co()
			
				local auto_shrug_time
				local shrug_healing = managers.player:has_category_upgrade("player", "damage_control_healing") and managers.player:upgrade_value("player", "damage_control_healing") * 0.01
			
				local function shrug_off_damage()
					local player_unit = managers.player:player_unit()

					if player_unit then
						local player_damage = player_unit:character_damage()
						local remaining_damage = player_damage:clear_delayed_damage()
						local is_downed = game_state_machine:verify_game_state(GameStateFilters.downed)
						local swan_song_active = managers.player:has_activate_temporary_upgrade("temporary", "berserker_damage_multiplier")

						if is_downed or swan_song_active then
							return
						end

						if shrug_healing then
							player_damage:restore_health(remaining_damage * shrug_healing, true)
						end
					end

					auto_shrug_time = nil
				end
			
				while true do
					coroutine.yield()

					local now = timer:time()

					if auto_shrug_time and auto_shrug_time <= now then
						shrug_off_damage()
					end
				end
			end
		-------------------------------------------------------------------------------------
			managers.player._coroutine_mgr:add_coroutine('damage_control', co)
		end
	end
end


local origfunc2 = TradeManager.clbk_begin_hostage_trade
function TradeManager:clbk_begin_hostage_trade(...)
	if not (self._criminals_to_respawn and self._criminals_to_respawn[1]) then
		return
	end
	origfunc2(self, ...)
end