local origfunc = MissionEndState.at_enter
function MissionEndState:at_enter(...)
	origfunc(self, ...)
	self:set_completion_bonus_done(true)
end