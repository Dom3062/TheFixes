TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_sync_convert_unitnetwork then
	local origfunc = UnitNetworkHandler.sync_unit_converted
	function UnitNetworkHandler:sync_unit_converted(unit, ...)
		if alive(unit) and unit:brain() then
			return origfunc(self, unit, ...)
		end
	end
end

if not TheFixesPreventer.crash_sync_tear_gas_unitnetwork then
	local origfunc2 = UnitNetworkHandler.sync_tear_gas_grenade_properties
	function UnitNetworkHandler:sync_tear_gas_grenade_properties(grenade, ...)
		if grenade and grenade:base() then
			return origfunc2(self, grenade, ...)
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

if not TheFixesPreventer.crashes_unit_nil_unitnetwork then
	local orig_names = {
		'sync_sentrygun_dynamic',
		'sentrygun_ammo',
		'sentrygun_sync_armor_piercing',
		'sync_fire_mode_interaction',
		'sentrygun_health',
		'turret_idle_state',
		'turret_update_shield_smoke_level',
		'turret_repair',
		'turret_complete_repairing',
		'turret_repair_shield'
	}

	local origs = {}
	for k,v in pairs(orig_names) do
		if UnitNetworkHandler[v] then
			origs[v] = UnitNetworkHandler[v]
			
			UnitNetworkHandler[v] = function(this, unit, ...)
				if unit then
					origs[v](this, unit, ...)
				end
			end
		end
	end
end