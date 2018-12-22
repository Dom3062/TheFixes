core:module("PlatformManager")
local rich_pres_orig = WinPlatformManager.set_rich_presence
function WinPlatformManager:set_rich_presence(...)
	if not managers.network.matchmake.lobby_handler then
		managers.network.matchmake.lobby_handler = { id = function(this) return nil end }
		rich_pres_orig(self, ...)
		managers.network.matchmake.lobby_handler = nil
	else
		rich_pres_orig(self, ...)
	end
end