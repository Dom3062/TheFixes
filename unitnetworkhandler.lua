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

if not TheFixesPreventer.crash_sync_throw_projectile_unitnetwork then
	-- unitnetworkhandler.lua"]:2536: attempt to call method 'set_owner_peer_id' (a nil value)
	local sync_throw_projectile_orig = UnitNetworkHandler.sync_throw_projectile
	function UnitNetworkHandler:sync_throw_projectile(unit, ...)
		if unit and unit.base and unit:base() and unit:base().set_owner_peer_id then
			sync_throw_projectile_orig(self, unit, ...)
		end
	end
end
