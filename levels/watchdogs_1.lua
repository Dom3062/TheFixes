TheFixesPreventer = TheFixesPreventer or {}
if TheFixesPreventer.heist_watchdogs_driver then
	return
end

-- This fixes the issue when you can kill the escape driver and activate the chopper

if Network:is_client() then
	return
end

-- Disable the two elements that trigger upon the car hitbox destruction
-- They make the driver appear as killed and call the helicopter
-- with 'armored car' asset
local carbeenShotASSET = managers.mission:get_element_by_id(101078)
if carbeenShotASSET then
	carbeenShotASSET._values.enabled = false
end
-- without the asset
local carBeenShot = managers.mission:get_element_by_id(101144)
if carBeenShot then
	carBeenShot._values.enabled = false
end

local lastId = 999999
local function GetId()
	lastId = lastId + 1
	while managers.mission:get_element_by_id(lastId) do
		lastId = lastId + 1
	end
	return lastId
end

-- This element will enable them ^ again, but only when we execute it
GetId()
local toggleCarBeenShot = {
	class = 'ElementToggle',
	module = 'CoreElementToggle',
	editor_name = 'the_fixes_driver_protection_toggle',
	id = lastId,
	values = {
		enabled = true,
		toggle = 'on',
		trigger_times = -1,
		base_delay = 10,
		elements = { 101078, 101144 }, -- carbeenShotASSET, carBeenShot
		set_trigger_times = -1,
		on_executed = {}
	}
}

local lastIndex

-- This 'hooks' the new element above to the element that enables '!' waypoint
local justBeforeCarComesIn = managers.mission:get_element_by_id(101471)
if justBeforeCarComesIn then
	lastIndex = #justBeforeCarComesIn._values.on_executed      -- toggleCarBeenShot
	justBeforeCarComesIn._values.on_executed[lastIndex + 1] = { id = lastId, delay = 0 }
end

-- This makes sure that carbeenShotASSET and carbeenShot don't get enabled when you buy the asset
local logic_toggle_024 = managers.mission:get_element_by_id(101601)
if logic_toggle_024 then
	logic_toggle_024._values.toggle = 'off'
end

-- Add a listener for hitbox 2 (asset) for the element that activates car crash
local hit = managers.mission:get_element_by_id(101085)
if hit then
	local sec = hit._values.sequence_list[1]
	managers.mission:add_runned_unit_sequence_trigger(sec.unit_id, 'done_hitbox2', callback(hit, hit, "on_executed"))
end

-- This 'hooks' the helicopter call to the car crash sequence
local func_sequence_009 = managers.mission:get_element_by_id(101090)
if func_sequence_009 then
	lastIndex = #func_sequence_009._values.on_executed         -- bain_20
	func_sequence_009._values.on_executed[lastIndex + 1] = { id = 101067, delay = 10 }
end

-- This finds the mission script with the crash sequence and adds the new element to it
-- This is necessary because elements from different scripts can't execute each other
for name, script in pairs(managers.mission._scripts) do
	if script:element(101090) then
		script:_create_elements({ toggleCarBeenShot })
		break
	end
end