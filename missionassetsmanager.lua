local TF = TheFixes
if TF:CheckLoadHook("MissionAssetsManager") then
    return
end

function MissionAssetsManager:unlock_all_availible_assets()
	for _, asset in pairs(self._global.assets) do
		if asset.show and not asset.unlocked and self:get_asset_can_unlock_by_id(asset.id) and managers.money:can_afford_mission_asset(asset.id) then
			self:unlock_asset(asset.id, true)
		end
	end
end