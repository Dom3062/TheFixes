if _G.Poser then return end

TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_custom_deployable_menusceneman then
	local origfunc = MenuSceneManager.set_character_deployable
	function MenuSceneManager:set_character_deployable(deployable_id, unit, peer_id, ...)
		if not self._deployable_equipped[peer_id]
			or not tweak_data.equipments[self._deployable_equipped[peer_id]]
		then
			self._deployable_equipped[peer_id] = "nil"
		end
		
		if not deployable_id
			or not tweak_data.equipments[deployable_id]
		then
			deployable_id = "nil"
		end
		
		return origfunc(self, deployable_id, unit, peer_id, ...)
	end
end