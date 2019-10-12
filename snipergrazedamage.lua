TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_weap_fired_snipergrazedamage then
	local origfunc = SniperGrazeDamage.on_weapon_fired
	function SniperGrazeDamage:on_weapon_fired(weapon_unit, result, ...)
		if weapon_unit and result then
			origfunc(self, weapon_unit, result, ...)
		end
	end
end
