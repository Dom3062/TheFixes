TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_weap_fired_snipergrazedamage then
	local origfunc = SniperGrazeDamage.on_weapon_fired
	function SniperGrazeDamage:on_weapon_fired(weapon_unit, result, ...)
		if weapon_unit and result then
			result.rays = result.rays or {}
			
			for inx, hit in ipairs(result.rays) do
				local res = hit.damage_result or {}
				if not res.attack_data then
					result.rays[inx] = nil
				end
			end
			
			origfunc(self, weapon_unit, result, ...)
		end
	end
end