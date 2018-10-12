-- Fix for objective=nil
local origfunc = GroupAIStateBase.on_criminal_objective_complete
function GroupAIStateBase:on_criminal_objective_complete(unit, objective, ...)
	if objective then
		origfunc(self, unit, objective, ...)
	end
end