-- This should fix the crash when a bot is in custody and a player joins
local origfunc = HUDManager.add_mugshot_by_unit
function HUDManager:add_mugshot_by_unit(unit, ...)
	if unit and unit:base() then
		origfunc(self, ...)
	end
end