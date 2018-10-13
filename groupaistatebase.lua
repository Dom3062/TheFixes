-- Fix for the bug when there is too many dozers
local origfunc = GroupAIStateBase._init_misc_data
function GroupAIStateBase:_init_misc_data(...)
	origfunc(self, ...)
	self._special_unit_types = self._special_unit_types or {}
	self._special_unit_types['tank_mini'] = true
	self._special_unit_types['tank_medic'] = true
end

-- Fix for the bug when there is too many dozers #2
local origfunc2 = GroupAIStateBase.on_simulation_started
function GroupAIStateBase:on_simulation_started(...)
	origfunc(self, ...)
	self._special_unit_types = self._special_unit_types or {}
	self._special_unit_types['tank_mini'] = true
	self._special_unit_types['tank_medic'] = true
end