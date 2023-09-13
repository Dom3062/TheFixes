-- By Hoppip (with permission)
local TF = TheFixes
TheFixesPreventer = TheFixesPreventer or {}
if TF._cache.fix_unnecessary_bandwidth_movement_sync or TheFixesPreventer.fix_unnecessary_bandwidth_movement_sync then
	return
end
if BLT and BLT.Mods and not TF._cache.fix_unnecessary_bandwidth_movement_sync_checked then
	local mods = BLT.Mods:Mods()
	for _, v in ipairs(mods) do
		if v.name and v.name:lower() == 'bandwidth saver' then
			log('[The Fixes] fix_unnecessary_bandwidth_movement_sync disabled')
			TF._cache.fix_unnecessary_bandwidth_movement_sync = true
			return
		end
	end
	TF._cache.fix_unnecessary_bandwidth_movement_sync_checked = true
end

--https://steamcommunity.com/app/218620/discussions/14/3782498683139018706/

local original = NetworkTweakData.init
function NetworkTweakData:init(...)
    original(self, ...)
    self.player_max_sync_t = 1 / 10
    if self.camera then
        self.camera.network_max_sync_t = 1 / 10
    end
end