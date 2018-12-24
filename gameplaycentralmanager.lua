local lastunit = nil
local origfunc = GamePlayCentralManager._do_shotgun_push
function GamePlayCentralManager:_do_shotgun_push(unit, ...)
	if lastunit and lastunit == unit
		and (not TheFixes or TheFixes.shotgun_push)
	then
		return
	end
	lastunit = unit
	return origfunc(self, unit, ...)
end