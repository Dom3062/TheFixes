TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.no_fall_dmg_respawn_trademan then
	-- Fall damage one time immunity after respawning
	local origfunc = TradeManager.criminal_respawn
	function TradeManager:criminal_respawn(pos, rotation, respawn_criminal, ...)
		origfunc(self, pos, rotation, respawn_criminal, ...)
		
		local peer_id = managers.criminals:character_peer_id_by_name(respawn_criminal.id)
		if peer_id == managers.network:session():local_peer():id() then
			local unit = managers.player:player_unit()
			local cd = unit and unit:character_damage()
			local state = managers.player:get_current_state()
			if cd and state then
				state:_update_ground_ray()
				if not state._gnd_ray then
					cd.the_fixes_fall_dmg_immune = true
				end
			end
		end
	end
end

if not TheFixesPreventer.crash_begin_trade_trademan then
	local origfunc2 = TradeManager.clbk_begin_hostage_trade
	function TradeManager:clbk_begin_hostage_trade(...)
		if not (self._criminals_to_respawn and self._criminals_to_respawn[1]) then
			return
		end
		origfunc2(self, ...)
	end
end