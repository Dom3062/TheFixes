-- Unsync the second circle cutter
local origfunc = UnitNetworkHandler.special_eq_response
function UnitNetworkHandler:special_eq_response(unit, ...)
	local ui = unit:interaction()
	if ui._special_equipment
		and ui._special_equipment == 'circle_cutter'
		and managers.player:has_special_equipment('circle_cutter') -- if not then it's fixed
	then
		return
	end
	origfunc(self, unit, ...)
end