TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_weap_td_raycastbase then
	local origfunc = RaycastWeaponBase.weapon_tweak_data
	function RaycastWeaponBase:weapon_tweak_data(...)
		return origfunc(self, ...) or tweak_data.weapon.ak5 or {}
	end
end

if not TheFixesPreventer.crash_create_setups_raycastbase then
	local cr_use_setups_orig = RaycastWeaponBase._create_use_setups
	function RaycastWeaponBase:_create_use_setups(...)
		if not tweak_data.weapon[self._name_id] then
			return
		end
		
		if not tweak_data.weapon[self._name_id].use_data then
			tweak_data.weapon[self._name_id].use_data = {
						selection_index = 2,
						align_place = "right_hand"
					}
		end
		
		return cr_use_setups_orig(self, ...)
	end
end