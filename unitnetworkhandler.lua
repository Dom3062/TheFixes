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

if not TheFixesPreventer.crash_sync_vehicle_player_unitnetwork then
	--https://steamcommunity.com/app/218620/discussions/14/3430074800219422411/
	local sync_vehicle_player_orig = UnitNetworkHandler.sync_vehicle_player
	function UnitNetworkHandler:sync_vehicle_player(action, vehicle, peer_id, player, seat_name)
		if action == "enter" and vehicle and peer_id and player and seat_name then
			sync_vehicle_player_orig(self, action, vehicle, peer_id, player, seat_name)
		elseif action == "exit" and peer_id and player then
			sync_vehicle_player_orig(self, action, vehicle, peer_id, player, seat_name)
		end
	end
end