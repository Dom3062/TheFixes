TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_criminal_obj_complete_aistatebase then
	-- Fix for objective=nil
	local origfunc = GroupAIStateBase.on_criminal_objective_complete
	function GroupAIStateBase:on_criminal_objective_complete(unit, objective, ...)
		if objective then
			origfunc(self, unit, objective, ...)
		end
	end
end