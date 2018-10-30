-- Make civilians go straight to the player they are following
local origfunc = CivilianLogicTravel._determine_exact_destination
function CivilianLogicTravel._determine_exact_destination(data, objective, ...)
	if objective
		and objective.type == 'follow'
		and objective.follow_unit
	then
		return objective.follow_unit:movement():nav_tracker():field_position()
	end
	return origfunc(data, objective, ...)
end