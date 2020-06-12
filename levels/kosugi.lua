TheFixesPreventer = TheFixesPreventer or {}
if TheFixesPreventer.heist_shadow_raid_roof then
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
	editor_name = 'the_fixes_roof_bags_to_respawn_area',
	id = TheFixesLib.mission:GetId(),
	module = CoreElementArea,
	values = {
		enabled = true,
		depth = 870,
		height = 100,
		instigator = 'loot',
		radius = 250,
		shape_type = 'box',
		interval = 2,
		position = Vector3(-4210.4, -4860.95, 1130.96),
		rotation = Rotation(0, 15, 0),
		width = 820,
		trigger_on = 'on_enter',
		spawn_unit_elements = {},
		trigger_times = -1,
		base_delay = 0,
		on_executed = {{ id = el_carry_id, delay = 0 }}
	}
}
local carry_respawn = {
	class = 'ElementCarry',
	editor_name = 'the_fixes_roof_bags_to_respawn_carry',
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
	editor_name = 'the_fixes_roof_bags_to_respawn_lootbag',
	id = el_lootbag_id,
	values = {
		enabled = true,
		trigger_times = -1,
		base_delay = 0,
		carry_id = 'none',
		from_respawn = true,
		position = Vector3(-5057.29, -4205.86, 676.1),
		rotation = Rotation(0, 0, 0),
		on_executed = {}
	}
}
local params = {}
params.name = 'the_fixes_roof_bags_to_respawn'
params.activate_on_parsed = true
params.elements = { zone, carry_respawn, lootbag }

managers.mission:_add_script(params)
managers.mission:_activate_mission(params.name)
