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

-- If the deployable does not exist then make it ammo bag
local origfunc3 = BlackMarketManager.equipped_deployable
function BlackMarketManager:equipped_deployable(slot, ...)
	local res = origfunc3(self, slot, ...)
	
	if not tweak_data.equipments[res] then
		res = 'ammo_bag'
	end
	
	return res
end

-- Skip achievement locked melee weapons when changing them by scrolling
local origs_melee_names = {
	'equip_previous_melee_weapon',
	'equip_next_melee_weapon'
}
local origs_melee = {}
for k,v in pairs(origs_melee_names) do
	if BlackMarketManager[v] then
		origs_melee[v] = BlackMarketManager[v]
		BlackMarketManager[v] = function(self, ...)
			local res = origs_melee[v](self, ...)
			
			if res then
				local current = self:equipped_melee_weapon()
				local td = tweak_data.blackmarket.melee_weapons[current]
				if td.locks and td.locks.achievement then
					local info = managers.achievment:get_info(td.locks.achievement)
					if not info.awarded then
						return self[v](self, ...)
					end
				elseif self['has_unlocked_'..current] then
					local name = 'has_unlocked_'..current
					if type(self[name]) == 'function'
						and not self[name]()
					then
						return self[v](self, ...)
					end
				end
			end
			
			return res
		end
	end
end