TheFixesPreventer = TheFixesPreventer or {}
if TheFixesPreventer.heist_safehouse_wall_cover then
	return
end

safe_spawn_unit(Idstring('units/payday2/props/air_prop_runway_fence/air_prop_runway_fence_cloth'), Vector3(-12, 2001, -421), Rotation(0,0,0))