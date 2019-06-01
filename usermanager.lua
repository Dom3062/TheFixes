core:module("UserManager")

TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_set_settings_map_userman then
	-- usermanager.lua:817: bad argument #1 to 'pairs' (table expected, got nil)
	local set_settings_map_orig = GenericUserManager.set_setting_map
	function GenericUserManager:set_setting_map(setting_map, ...)
		return set_settings_map_orig(self, setting_map or {}, ...)
	end
end