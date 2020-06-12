TheFixesPreventer = TheFixesPreventer or {}
if TheFixesPreventer.heist_prison_night_secure_zone then
	return
end

if not TheFixesLib or not TheFixesLib.mission then
    return
end

if Network:is_client() then
	return
end

local ids = { 
    TheFixesLib.mission:GetId(), 
    TheFixesLib.mission:GetId(), 
    TheFixesLib.mission:GetId()
}

local name = 'the_fixes_secure_zone'

local zone = {
	class = 'ElementAreaTrigger',
	editor_name = name..'_area',
	id = ids[1],
	module = CoreElementArea,
	values = {
		enabled = true,
		depth = 440,
		height = 30,
		instigator = 'loot',
		radius = 250,
		shape_type = 'box',
		interval = 1,
		position = Vector3(-2695,12215,1903),
		width = 214,
		trigger_on = 'on_enter',
		spawn_unit_elements = {},
		trigger_times = -1,
		base_delay = 0,
		on_executed = {{ id = ids[2], delay = 0 }, { id = ids[3], delay = 0 }}
	}
}

local carry_secure = {
	class = 'ElementCarry',
	editor_name = name..'_carry_secure',
	id = ids[2],
	values = {
		enabled = true,
		trigger_times = -1,
		base_delay = 0,
		operation = 'secure',
		on_executed = {}
	}
}

local carry_freeze = {
	class = 'ElementCarry',
	editor_name = name..'_carry_freeze',
	id = ids[3],
	values = {
		enabled = true,
		trigger_times = -1,
		base_delay = 0,
		operation = 'freeze',
		on_executed = {}
	}
}

local params = {}
params.name = name
params.activate_on_parsed = true
params.elements = { zone, carry_secure, carry_freeze }

managers.mission:_add_script(params)
managers.mission:_activate_mission(params.name)
