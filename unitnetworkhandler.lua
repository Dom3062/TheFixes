local origfunc = UnitNetworkHandler.sync_unit_converted
function UnitNetworkHandler:sync_unit_converted(unit, ...)
	if alive(unit) and unit:brain() then
		return origfunc(self, unit, ...)
	end
end


local origfunc2 = UnitNetworkHandler.sync_tear_gas_grenade_properties
function UnitNetworkHandler:sync_tear_gas_grenade_properties(grenade, ...)
	if grenade and grenade:base() then
		return origfunc2(self, grenade, ...)
	end
end


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