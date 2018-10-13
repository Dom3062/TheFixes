-- Unsync the second circle cutter
local origfunc = UnitNetworkHandler.special_eq_response
function UnitNetworkHandler:special_eq_response(unit, ...)
	local ui = unit:interaction()
	if ui._special_equipment
		and ui._special_equipment == 'circle_cutter'
	then
		local eq = managers.player:has_special_equipment('circle_cutter')
		if eq and eq.amount and eq.amount > 0 then -- if not then it's fixed
			return
		end
	end
	origfunc(self, unit, ...)
end