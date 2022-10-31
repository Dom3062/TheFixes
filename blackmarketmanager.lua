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
		if weapon_id and tweak_data.weapon[weapon_id] then
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

if not TheFixesPreventer.crash_get_char_by_name_blackmarket then
	-- menuscenemanager.lua:1219: attempt to index a nil value (modding crash)
	local get_char_by_name_orig = BlackMarketManager.get_character_id_by_character_name
	function BlackMarketManager:get_character_id_by_character_name(...)
		local res = get_char_by_name_orig(self, ...)
		
		if not tweak_data.blackmarket.characters[res] then
			return 'ai_dallas'
		end
		
		return res
	end
end

if not TheFixesPreventer.crash_calc_sus_offset_blackmarket then
	-- blackmarketmanager.lua"]:2979: attempt to perform arithmetic on local 'con_val' (a nil value)
	local calc_sus_offset_orig = BlackMarketManager._calculate_suspicion_offset
	function BlackMarketManager:_calculate_suspicion_offset(index, ...)
		if not tweak_data.weapon.stats.concealment[index] then
			index = #tweak_data.weapon.stats.concealment
		end
	
		return calc_sus_offset_orig(self, index, ...)
	end
end

if not TheFixesPreventer.crash_weap_unlock_by_craft_blackmarket then
	-- blackmarketmanager.lua"]:621: attempt to index local 'data' (a nil value)
	local weap_unlock_by_craft_orig = BlackMarketManager.weapon_unlocked_by_crafted
	function BlackMarketManager:weapon_unlocked_by_crafted(category, slot, ...)
		local crafted = self._global.crafted_items[category][slot]

		if crafted and crafted.weapon_id then
			if not Global.blackmarket_manager.weapons[crafted.weapon_id] then
				return false
			end
		end

		return weap_unlock_by_craft_orig(self, category, slot, ...)
	end
end

-- Fixed a typo in "Application" as "Applicaton" that could lead to a crash when using modded parts
if not TheFixesPreventer.crash_custom_color_switch then 
	-- blackmarketmanager.lua:6429: attempt to index global 'Applicaton' (a nil value)
	local set_part_custom_colors_orig = BlackMarketManager.set_part_custom_colors
	function BlackMarketManager:set_part_custom_colors(category, slot, part_id, colors,...)
		local part_data = tweak_data.weapon.factory.parts[part_id]

		if not part_data then
			Application:error("[BlackMarketManager:set_part_custom_colors] Part do not exist", "category", category, "slot", slot, "part_id", part_id, "texture_id", texture_id)

			return
		end
		return set_part_custom_colors_orig(self, category, slot, part_id, colors,...)
	end
end

-- Fixed a typo in "Application" as "Applicaton" that could lead to a crash when using modded parts
if not TheFixesPreventer.crash_custom_texture_switch then 
	local set_part_texture_switch_orig = BlackMarketManager.set_part_texture_switch
	function BlackMarketManager:set_part_texture_switch(category, slot, part_id, data_string,...)
		local part_data = tweak_data.weapon.factory.parts[part_id]

		if not part_data then
			Application:error("[BlackMarketManager:set_part_texture_switch] Part do not exist", "category", category, "slot", slot, "part_id", part_id, "texture_id", texture_id)

			return
		end

		return set_part_texture_switch_orig(self, category, slot, part_id, data_string,...)
	end
end

if not TheFixesPreventer.crash_weapon_colors_have_boost_field then
	-- blackmarketmanager.lua"]:2934: attempt to perform arithmetic on local 'value' (a table value)
	-- Probably caused by mods
	-- Removes "bonus" field if the cosmetic is a weapon color
	local _f_get_weapon_stats = BlackMarketManager._get_weapon_stats
	function BlackMarketManager:_get_weapon_stats(weapon_id, blueprint, cosmetics, ...)
		if cosmetics and cosmetics.id then
			local skin = tweak_data.blackmarket.weapon_skins[cosmetics.id]
			if skin and skin.is_a_color_skin then
				cosmetics.bonus = nil
			end
		end
		return _f_get_weapon_stats(self, weapon_id, blueprint, cosmetics, ...)
	end
end