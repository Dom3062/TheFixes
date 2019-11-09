TheFixesPreventer = TheFixesPreventer or {}
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

if not TheFixesPreventer.crash_on_collision_raycastbase then
	local on_coll_orig = InstantExplosiveBulletBase.on_collision
	function InstantExplosiveBulletBase:on_collision(col_ray, ...)
		if not col_ray.unit then return nil end
		return on_coll_orig(self, col_ray, ...)
	end
end
	