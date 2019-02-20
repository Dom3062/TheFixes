TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_weap_td_raycastbase then
	local origfunc = RaycastWeaponBase.weapon_tweak_data
	function RaycastWeaponBase:weapon_tweak_data(...)
		return origfunc(self, ...) or tweak_data.weapon.ak5 or {}
	end
end