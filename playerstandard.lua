-- Fix for endless shooting after bleedout
-- https://steamcommunity.com/app/218620/discussions/14/144513248272843703/
local origfunc = PlayerStandard.exit
function PlayerStandard:exit(...)
	if self._shooting then
		self._shooting = false
		if not self._equipped_unit:base().akimbo then
			self._ext_network:send("sync_stop_auto_fire_sound")
		end
		self._equipped_unit:base():stop_shooting()
		self._camera_unit:base():stop_shooting()
	end
	return origfunc(self, ...)
end