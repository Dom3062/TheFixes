TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_custom_weap_and_parts then
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
end

if not TheFixesPreventer.crash_custom_mask then
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
end

if not TheFixesPreventer.crash_custom_deployable then
	-- Handle a non-existent deployable
	local origfunc3 = BlackMarketManager.equipped_deployable
	function BlackMarketManager:equipped_deployable(slot, ...)
		local res = origfunc3(self, slot, ...)
		
		if not tweak_data.equipments[res] then
			return nil
		end
		
		if slot == 2 and not managers.player:has_category_upgrade("player", "second_deployable") then
			return nil
		end
		
		return res
	end
end

if not TheFixesPreventer.check_achi_scroll_melee then
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
end

if not TheFixesPreventer.crash_custom_van_skin then
	-- Custom van skins ? crash fix
	local van_skin_orig = BlackMarketManager.equipped_van_skin
	function BlackMarketManager:equipped_van_skin(...)
		local res = van_skin_orig(self, ...) or ''
		
		if not tweak_data.van.skins[res] then
			return tweak_data.van.default_skin_id
		end
		
		return res
	end
end

if not TheFixesPreventer.crash_weapon_platform_blackmarket then
	-- https://steamcommunity.com/app/218620/discussions/14/1744479063999467293/
	local acq_weap_plm_orig = BlackMarketManager.on_aquired_weapon_platform
	function BlackMarketManager:on_aquired_weapon_platform(upgrade, ...)
		if upgrade
			and upgrade.weapon_id
			and tweak_data.weapon[upgrade.weapon_id]
			and tweak_data.weapon[upgrade.weapon_id].use_data
		then
			acq_weap_plm_orig(self, upgrade, ...)
		end
	end
end

if not TheFixesPreventer.crash_add_to_inv_blackmarket then
	local add_crafted_to_inv_orig = BlackMarketManager.add_crafted_weapon_blueprint_to_inventory
	function BlackMarketManager:add_crafted_weapon_blueprint_to_inventory(category, slot, ...)
		if not self._global.crafted_items[category] or not self._global.crafted_items[category][slot]
			or not self._global.crafted_items[category][slot].blueprint
		then
			if self._global.crafted_items[category] then
				self._global.crafted_items[category][slot] = nil
			end
			return
		end
		
		add_crafted_to_inv_orig(self, category, slot, ...)
	end
end