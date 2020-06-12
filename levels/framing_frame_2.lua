TheFixesPreventer = TheFixesPreventer or {}
if TheFixesPreventer.heist_framframe2_bags_teleport then
	return
end

if not TheFixesLib or not TheFixesLib.mission then
    return
end

if Network:is_client() then
	return
end

local el_carry_id = TheFixesLib.mission:GetId()
local el_lootbag_id = TheFixesLib.mission:GetId()
local zone = {
	class = 'ElementAreaTrigger',
	editor_name = 'the_fixes_bags_out_of_map_area',
	id = TheFixesLib.mission:GetId(),
	module = CoreElementArea,
	values = {
		enabled = true,
		depth = 1050,
		height = 400,
		instigator = 'loot',
		radius = 250,
		shape_type = 'box',
		interval = 2,
		position = Vector3(10107.61, 903.44, 175),
		rotation = Rotation(0, 0, 0),
		width = 2000,
		trigger_on = 'on_enter',
		spawn_unit_elements = {},
		trigger_times = -1,
		base_delay = 0,
		on_executed = {{ id = el_carry_id, delay = 0 }}
	}
}
local zone2 = {
	class = 'ElementAreaTrigger',
	editor_name = 'the_fixes_bags_out_of_map_area_2',
	id = TheFixesLib.mission:GetId(),
	module = CoreElementArea,
	values = {
		enabled = true,
		depth = 870,
		height = 200,
		instigator = 'loot',
		radius = 250,
		shape_type = 'box',
		interval = 2,
		position = Vector3(8830.34, 450.541, 553.3),
		rotation = Rotation(0, -15, 0),
		width = 1800,
		trigger_on = 'on_enter',
		spawn_unit_elements = {},
		trigger_times = -1,
		base_delay = 0,
		on_executed = {{ id = el_carry_id, delay = 0 }}
	}
}
local carry_respawn = {
	class = 'ElementCarry',
	editor_name = 'the_fixes_bags_out_of_map_carry',
	id = el_carry_id,
	values = {
		enabled = true,
		trigger_times = -1,
		base_delay = 0,
		operation = 'add_to_respawn',
		on_executed = {{ id = el_lootbag_id, delay = 0 }}
	}
}
local lootbag = {
	class = 'ElementLootBag',
	editor_name = 'the_fixes_bags_out_of_map_lootbag',
	id = el_lootbag_id,
	values = {
		enabled = true,
		trigger_times = -1,
		base_delay = 0,
		carry_id = 'none',
		from_respawn = true,
		position = Vector3(9021.49, 960.383, 100),
		rotation = Rotation(0, 0, 0),
		on_executed = {}
	}
}
local params = {}
params.name = 'the_fixes_bags_out_of_map'
params.activate_on_parsed = true
params.elements = { zone, zone2, carry_respawn, lootbag }

managers.mission:_add_script(params)
managers.mission:_activate_mission(params.name)