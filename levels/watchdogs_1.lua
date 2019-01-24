-- Spawn several walls to protect the escape driver

if Network:is_client() then
	return
end

local posrots = {
	{ Vector3(-2800, -7823, 0), Rotation(0, 0, 0) },
	{ Vector3(-2800, -7823, 296), Rotation(0, 0, 0) },
	{ Vector3(-2800, -7823, 596), Rotation(0, 0, 0) },
	{ Vector3(-3200, -7826, 243), Rotation(0, 0, 0) },
	{ Vector3(-3200, -7826, 542), Rotation(0, 0, 0) },
	{ Vector3(-3578, -7824, 248), Rotation(0, 0, 0) },
	{ Vector3(-3578, -7824, 542), Rotation(0, 0, 0) },
	{ Vector3(-2893, -8391, -40), Rotation(-90, 0, 0) }
}

for k,v in pairs(posrots) do
	safe_spawn_unit(Idstring('units/world/architecture/desert/des_vil_house/des_vil_house_wall_4x3_cind'), v[1], v[2])
end