local origfunc = SniperGrazeDamage.on_weapon_fired
function SniperGrazeDamage:on_weapon_fired(weapon_unit, result, ...)
	if weapon_unit and result.attack_data then
		origfunc(self, weapon_unit, result, ...)
	end
end