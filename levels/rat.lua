TheFixesPreventer = TheFixesPreventer or {}
if TheFixesPreventer.heist_alex_1_rat then
	return
end

-- Scripted spawns are handled by host
if Network:is_client() or Global.game_settings.difficulty ~= "sm_wish" then
    return
end

-- Scripted green dozer
local elem = managers.mission:get_element_by_id(100952) -- ´ai_spawn_enemy_054´ ElementSpawnEnemyDummy 100952
if elem then
    elem._enemy_name = Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_bulldozer_2/ene_zeal_bulldozer_2")
end