local add_u_by_blue_orig = HuskPlayerInventory.add_unit_by_factory_blueprint
function HuskPlayerInventory:add_unit_by_factory_blueprint(factory_name, ...)
	if tweak_data.weapon.factory[factory_name] then
		add_u_by_blue_orig(self, factory_name, ...)
	end
end