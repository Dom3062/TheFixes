TheFixesPreventer = TheFixesPreventer or {}
if TheFixesPreventer.heist_rats_3_collision then
	return
end

-- Add a collision to prevent players from getting out of playable area

local collision = safe_spawn_unit(Idstring('units/dev_tools/level_tools/collision/dev_collision_50m/dev_collision_50m'), Vector3(19272, 22983, 1906), Rotation(90,0,0))
collision:set_visible(false)