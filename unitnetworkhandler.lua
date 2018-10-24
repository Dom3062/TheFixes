local origfunc = UnitNetworkHandler.sync_unit_converted
function UnitNetworkHandler:sync_unit_converted(unit, ...)
	if alive(unit) and unit:brain() then
		return origfunc(self, unit, ...)
	end
end