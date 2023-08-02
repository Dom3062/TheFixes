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

-- Fix for the bug when there is too many dozers
local origfunc3 = GroupAIStateBase._init_misc_data
function GroupAIStateBase:_init_misc_data(...)
	origfunc3(self, ...)
	self._special_unit_types = self._special_unit_types or {}
	self._special_unit_types['tank_mini'] = true
	self._special_unit_types['tank_medic'] = true
end

-- Fix for the bug when there is too many dozers #2
local origfunc2 = GroupAIStateBase.on_simulation_started
function GroupAIStateBase:on_simulation_started(...)
	origfunc2(self, ...)
	self._special_unit_types = self._special_unit_types or {}
	self._special_unit_types['tank_mini'] = true
	self._special_unit_types['tank_medic'] = true
end