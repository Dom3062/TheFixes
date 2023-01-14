TheFixesPreventer = TheFixesPreventer or {}
if TheFixesPreventer.heist_pbr then
	return
end

-- Scripted spawns are handled by host
if Network:is_client() then
    return
end

local function GetFinalID(id, instance_start_index)
    return id + 30000 + instance_start_index
end

local green_dozer = "units/pd2_dlc_bph/characters/ene_murkywater_bulldozer_2/ene_murkywater_bulldozer_2"
local black_dozer = "units/pd2_dlc_bph/characters/ene_murkywater_bulldozer_3/ene_murkywater_bulldozer_3"
local skull_dozer = "units/pd2_dlc_bph/characters/ene_murkywater_bulldozer_4/ene_murkywater_bulldozer_4"

-- pbr_mountain_control_room
local elem = managers.mission:get_element_by_id(GetFinalID(100044, 400)) -- ´dozer_black´ ElementSpawnEnemyDummy 100044
if elem then
    elem._enemy_name = black_dozer
end
elem = managers.mission:get_element_by_id(GetFinalID(100066, 400)) -- ´dozer_green´ ElementSpawnEnemyDummy 100066
if elem then
    elem._enemy_name = green_dozer
end
elem = managers.mission:get_element_by_id(GetFinalID(100079, 400)) -- ´dozer_deathwish´ ElementSpawnEnemyDummy 100079
if elem then
    elem._enemy_name = skull_dozer
end

-- pbr_mountain_surface
local sniper = "units/pd2_dlc_bph/characters/ene_murkywater_sniper/ene_murkywater_sniper"
elem = managers.mission:get_element_by_id(GetFinalID(100000, 10950)) -- ´top_sniper001´ ElementSpawnEnemyDummy 100000
if elem then
    elem._enemy_name = sniper
end
elem = managers.mission:get_element_by_id(GetFinalID(100011, 10950)) -- ´top_sniper002´ ElementSpawnEnemyDummy 100011
if elem then
    elem._enemy_name = sniper
end
elem = managers.mission:get_element_by_id(GetFinalID(100013, 10950)) -- ´top_sniper003´ ElementSpawnEnemyDummy 100013
if elem then
    elem._enemy_name = sniper
end
elem = managers.mission:get_element_by_id(GetFinalID(100014, 10950)) -- ´top_sniper004´ ElementSpawnEnemyDummy 100014
if elem then
    elem._enemy_name = sniper
end
elem = managers.mission:get_element_by_id(GetFinalID(100015, 10950)) -- ´top_sniper005´ ElementSpawnEnemyDummy 100015
if elem then
    elem._enemy_name = sniper
end
elem = managers.mission:get_element_by_id(GetFinalID(101466, 10950)) -- ´surface_sniper_001´ ElementSpawnEnemyDummy 101466
if elem then
    elem._enemy_name = sniper
end
elem = managers.mission:get_element_by_id(GetFinalID(101468, 10950)) -- ´surface_sniper_002´ ElementSpawnEnemyDummy 101468
if elem then
    elem._enemy_name = sniper
end
elem = managers.mission:get_element_by_id(GetFinalID(101469, 10950)) -- ´surface_sniper_003´ ElementSpawnEnemyDummy 101469
if elem then
    elem._enemy_name = sniper
end
elem = managers.mission:get_element_by_id(GetFinalID(101470, 10950)) -- ´surface_sniper_004´ ElementSpawnEnemyDummy 101470
if elem then
    elem._enemy_name = sniper
end
elem = managers.mission:get_element_by_id(GetFinalID(101471, 10950)) -- ´surface_sniper_005´ ElementSpawnEnemyDummy 101471
if elem then
    elem._enemy_name = sniper
end
-- Sniper ambush
for i = 100214, 100221, 1 do
    elem = managers.mission:get_element_by_id(GetFinalID(i, 10950)) -- ´sniper_ambush´ ElementSpawnEnemyDummy 100214 - 100221
    if elem then
        elem._enemy_name = sniper
    end
end
-- Dozer ambush
elem = managers.mission:get_element_by_id(GetFinalID(100244, 10950)) -- ´dozer_hell_normal001´ ElementSpawnEnemyDummy 100244
if elem then
    elem._enemy_name = black_dozer
end
elem = managers.mission:get_element_by_id(GetFinalID(100253, 10950)) -- ´dozer_hell_normal002´ ElementSpawnEnemyDummy 100253
if elem then
    elem._enemy_name = black_dozer
end
elem = managers.mission:get_element_by_id(GetFinalID(100256, 10950)) -- ´dozer_hell_normal003´ ElementSpawnEnemyDummy 100256
if elem then
    elem._enemy_name = black_dozer
end
elem = managers.mission:get_element_by_id(GetFinalID(100271, 10950)) -- ´dozer_hell_normal004´ ElementSpawnEnemyDummy 100271
if elem then
    elem._enemy_name = black_dozer
end
elem = managers.mission:get_element_by_id(GetFinalID(100273, 10950)) -- ´dozer_hell_normal005´ ElementSpawnEnemyDummy 100273
if elem then
    elem._enemy_name = black_dozer
end
elem = managers.mission:get_element_by_id(GetFinalID(100275, 10950)) -- ´dozer_hell_normal006´ ElementSpawnEnemyDummy 100275
if elem then
    elem._enemy_name = black_dozer
end
elem = managers.mission:get_element_by_id(GetFinalID(100277, 10950)) -- ´dozer_hell_normal007´ ElementSpawnEnemyDummy 100277
if elem then
    elem._enemy_name = black_dozer
end

-- Snipers
-- Exterior
elem = managers.mission:get_element_by_id(100605) -- ´exterior_sniper_004´ ElementSpawnEnemyDummy 100605
if elem then
    elem._enemy_name = sniper
end
elem = managers.mission:get_element_by_id(100606) -- ´exterior_sniper_005´ ElementSpawnEnemyDummy 100606
if elem then
    elem._enemy_name = sniper
end
-- After airlock
for i = 101236, 101239, 1 do -- ´exterior_sniper´ ElementSpawnEnemyDummy 101236 - 101239
    elem = managers.mission:get_element_by_id(i)
    if elem then
        elem._enemy_name = sniper
    end
end

-- Shields
-- After airlock
local shield = "units/pd2_dlc_bph/characters/ene_murkywater_shield/ene_murkywater_shield"
elem = managers.mission:get_element_by_id(101122) -- ´slope_normal_force003´ ElementSpawnEnemyDummy 101122
if elem then
    elem._enemy_name = shield
end
for i = 100400, 100403, 1 do -- ´shield_wall´ ElementSpawnEnemyDummy 100400 - 100403
    elem = managers.mission:get_element_by_id(i)
    if elem then
        elem._enemy_name = shield
    end
end
elem = managers.mission:get_element_by_id(101498) -- ´slope_hard_force003´ ElementSpawnEnemyDummy 101498
if elem then
    elem._enemy_name = shield
end
elem = managers.mission:get_element_by_id(101595) -- ´shield_wall_normal001´ ElementSpawnEnemyDummy 101595
if elem then
    elem._enemy_name = shield
end
elem = managers.mission:get_element_by_id(101596) -- ´shield_wall_hard001´ ElementSpawnEnemyDummy 101596
if elem then
    elem._enemy_name = shield
end
for i = 101601, 101606, 1 do -- ´shield_wall´ ElementSpawnEnemyDummy 101601 - 101606
    elem = managers.mission:get_element_by_id(i)
    if elem then
        elem._enemy_name = shield
    end
end

-- Dozers
-- After airlock
elem = managers.mission:get_element_by_id(100371) -- ´slope_easy_force001´ ElementSpawnEnemyDummy 100371
if elem then
    elem._enemy_name = green_dozer
end
elem = managers.mission:get_element_by_id(100372) -- ´slope_normal_force001´ ElementSpawnEnemyDummy 100372
if elem then
    elem._enemy_name = black_dozer
end
elem = managers.mission:get_element_by_id(100373) -- ´slope_hard_force001´ ElementSpawnEnemyDummy 100373
if elem then
    elem._enemy_name = skull_dozer
end