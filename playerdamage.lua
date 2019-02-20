TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.no_fall_dmg_respawn_playerdamage then
	-- Fall damage one time immunity after respawning
	local origfunc = PlayerDamage.damage_fall
	function PlayerDamage:damage_fall(...)
		if self.the_fixes_fall_dmg_immune then
			self.the_fixes_fall_dmg_immune = nil
			return
		end
		return origfunc(self, ...)
	end
end