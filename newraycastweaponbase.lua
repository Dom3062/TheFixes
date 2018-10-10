local origfunc = NewRaycastWeaponBase.get_all_override_weapon_gadgets
function NewRaycastWeaponBase:get_all_override_weapon_gadgets(...)
	local res = origfunc(self, ...) or {}
	return res
end