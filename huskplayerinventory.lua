TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_add_by_blueprint_huskplayerinv then
	local add_u_by_blue_orig = HuskPlayerInventory.add_unit_by_factory_blueprint
	function HuskPlayerInventory:add_unit_by_factory_blueprint(factory_name, ...)
		if tweak_data.weapon.factory[factory_name] then
			add_u_by_blue_orig(self, factory_name, ...)
		end
	end
end

if not TheFixesPreventer.crash_align_place_huskplayerinv then
	function HuskPlayerInventory:_align_place(...)
		local res1, res2 = HuskPlayerInventory.super._align_place(self, ...)
		if res1 and res2 then
			return res1, res2
		elseif debug.getinfo(2).name == 'add_unit_by_factory_blueprint' then
			return res1 or {}
		else
			return res1
		end
	end
end

if not TheFixesPreventer.crash_set_underbarrel then
	function HuskPlayerInventory:set_weapon_underbarrel(selection_index, underbarrel_id, is_on)
		selection_index = (tonumber(selection_index) - 1) % 2 + 1
		local selection = self._available_selections[selection_index]
		if not selection then
			return
		end
		if selection.unit and alive(selection.unit) and selection.unit.base and selection.unit:base() and selection.unit:base().set_underbarrel then --- <-------
			selection.unit:base():set_underbarrel(underbarrel_id, is_on)
		end
	end
end