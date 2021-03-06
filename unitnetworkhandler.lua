TheFixesPreventer = TheFixesPreventer or {}

if not TheFixesPreventer.crash_sync_tear_gas_unitnetwork then
	local origfunc2 = UnitNetworkHandler.sync_tear_gas_grenade_properties
	function UnitNetworkHandler:sync_tear_gas_grenade_properties(grenade, ...)
		if grenade and grenade:base() then
			return origfunc2(self, grenade, ...)
		end
	end

	local stggd_orig = UnitNetworkHandler.sync_tear_gas_grenade_detonate
	function UnitNetworkHandler:sync_tear_gas_grenade_detonate(grenade, ...)
		if grenade and grenade:base() then
			return stggd_orig(self, grenade, ...)
		end
	end
end

if not TheFixesPreventer.crash_sync_enter_vehi_unitnetwork then
	local sync_enter_vehicle_orig = UnitNetworkHandler.sync_enter_vehicle_host
	function UnitNetworkHandler:sync_enter_vehicle_host(vehicle, seat_name, peer_id, player, ...)
		if seat_name and peer_id and player then
			sync_enter_vehicle_orig(self, vehicle, seat_name, peer_id, player, ...)
		end
	end
end

if not TheFixesPreventer.crash_sync_drill_upgrades_unitnetwork then
	local sync_drill_upgrades_orig = UnitNetworkHandler.sync_drill_upgrades
	function UnitNetworkHandler:sync_drill_upgrades(unit, ...)
		if unit then
			return sync_drill_upgrades_orig(self, unit, ...)
		end
	end
end

if not TheFixesPreventer.fix_copmovement_aim_state_discarded then
	--local original = UnitNetworkHandler.action_aim_state
	-- This is bad, I shouldn't overwrite the whole function
	-- But this is will do
	-- New code separated with -------------
	function UnitNetworkHandler:action_aim_state(cop, state)
		if not self._verify_gamestate(self._gamestate_filter.any_ingame) or not self._verify_character(cop) then
			return
		end
		-------------
		if state then
		-------------
			local shoot_action = {
				block_type = "action",
				body_part = 3,
				type = "shoot"
			}
			cop:movement():action_request(shoot_action)
		-------------
		else
			cop:movement():sync_action_aim_end()
		end
		-------------
	end
end