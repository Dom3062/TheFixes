-- This allows us to mark achievements as failed
local origfunc = AchievmentManager.award
function AchievmentManager:award(id, ...)
	if AchievmentManager.the_fixes_failed
		and AchievmentManager.the_fixes_failed[id]
	then
		return
	end
	return origfunc(self, id, ...)
end