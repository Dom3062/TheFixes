TheFixesPreventer = TheFixesPreventer or {}
if TheFixesPreventer.heist_hox_revenge then
	return
end

-- https://steamcommunity.com/app/218620/discussions/14/2980782118455262899/

if not TheFixesLib
    or not TheFixesLib.deep_clone
    or not TheFixesLib.mission
then
    return
end

if Network:is_client() then
	return
end

local wife_killed_after_obj = TheFixesLib.mission.getElementByIdAndName(102099, 'wife_killed_after_obj')
if wife_killed_after_obj then
    table.insert(wife_killed_after_obj._values.on_executed, { id = 101526, delay = 0 })
end
