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