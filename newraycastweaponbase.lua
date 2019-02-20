TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_weap_gadgets_newraycast then
	local origfunc = NewRaycastWeaponBase.get_all_override_weapon_gadgets
	function NewRaycastWeaponBase:get_all_override_weapon_gadgets(...)
		local res = origfunc(self, ...) or {}
		return res
	end
end