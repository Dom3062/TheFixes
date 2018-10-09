-- This removes any weapon parts that are in the save file, but not in the game
-- Also prevents the crash if 'weapon' does not exist
local origfunc = BlackMarketManager.get_silencer_concealment_modifiers
function BlackMarketManager:get_silencer_concealment_modifiers(weapon, ...)
	for k,v in pairs(weapon.blueprint or {}) do
		if not tweak_data.weapon.factory.parts[v] then
			weapon.blueprint[k] = nil
		end
	end
	local weapon_id = weapon.weapon_id or (weapon.factory_id and managers.weapon_factory:get_weapon_id_by_factory_id(weapon.factory_id) or nil)
	if tweak_data.weapon[weapon_id] then
		return origfunc(self, weapon, ...)
	else
		return 0
	end
end


-- If the equipped mask does not exist then equip any other mask
local origfunc2 = BlackMarketManager.equipped_mask
function BlackMarketManager:equipped_mask(...)
	local res = origfunc2(self, ...)

	if not res then
		for slot, data in pairs(Global.blackmarket_manager.crafted_items.masks or {}) do
			if data then
				data.equipped = true
				return data
			end
		end
	end

	return res or 'mask_not_found'
end