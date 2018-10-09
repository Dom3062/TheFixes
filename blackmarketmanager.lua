-- This removes any weapon parts that are in the save file, but not in the game
local origfunc = BlackMarketManager.get_silencer_concealment_modifiers
function BlackMarketManager:get_silencer_concealment_modifiers(weapon, ...)
	for k,v in pairs(weapon.blueprint or {}) do
		if not tweak_data.weapon.factory.parts[v] then
			weapon.blueprint[k] = nil
		end
	end
	return origfunc(self, weapon, ...)
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