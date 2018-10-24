local origfunc = UnitNetworkHandler.sync_unit_converted
function UnitNetworkHandler:sync_unit_converted(unit, ...)
	if alive(unit) and unit:brain() then
		return origfunc(self, unit, ...)
	end
end


local origfunc2 = UnitNetworkHandler.sync_tear_gas_grenade_properties
function UnitNetworkHandler:sync_tear_gas_grenade_properties(grenade, ...)
	if grenade and grenade:base() then
		return origfunc(self, grenade, ...)
	end
end