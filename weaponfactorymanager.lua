TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_get_perks_weapfactory then
	local get_perks_orig = WeaponFactoryManager.get_perks
	function WeaponFactoryManager:get_perks(factory_id, blueprint, ...)
		if not blueprint then return {} end
		return get_perks_orig(self, factory_id, blueprint, ...)
	end
end