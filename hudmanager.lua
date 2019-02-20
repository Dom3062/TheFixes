TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_mugshot_by_unit_hudman then
	-- This should fix the crash when a bot is in custody and a player joins
	local origfunc = HUDManager.add_mugshot_by_unit
	function HUDManager:add_mugshot_by_unit(unit, ...)
		if unit and unit:base() then
			return origfunc(self, unit, ...)
		end
	end
end

if not TheFixesPreventer.crash_add_waypoint_hudman then
	-- hudmanager.lua:941: attempt to index field 'unit' (a nil value)
	local add_wp_orig = HUDManager.add_waypoint
	function HUDManager:add_waypoint(id, data, ...)
		if data.position or data.unit then
			add_wp_orig(self, id, data, ...)
		end
	end
end