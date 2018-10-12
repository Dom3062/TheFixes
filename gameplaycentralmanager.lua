local lastunit = nil
local origfunc = GamePlayCentralManager._do_shotgun_push
function GamePlayCentralManager:_do_shotgun_push(unit, ...)
	if lastunit and lastunit == unit:key() then
		return
	end
	lastunit = unit:key()
	return origfunc(self, unit, ...)
end