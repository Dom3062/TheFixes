-- Always pick up those cutters
local origfunc = PlayerManager._can_pickup_special_equipment
function PlayerManager:_can_pickup_special_equipment(special_equipment, name, ...)
	if special_equipment.amount and name == 'circle_cutter' then
		return true
	end
	return origfunc(self, special_equipment, name, ...)
end