TheFixesPreventer = TheFixesPreventer or {}
if TheFixesPreventer.heist_casino_softlock then
	return
end

-- https://steamcommunity.com/app/218620/discussions/14/2261313417704053655/

if not TheFixesLib
    or not TheFixesLib.deep_clone
    or not TheFixesLib.mission
then
    return
end

if Network:is_client() then
	return
end

local input_set_armory_ids = { 196543, 196793 }
for _, id in ipairs(input_set_armory_ids) do
    local input_set_armory = TheFixesLib.mission.getElementByIdAndName(id, 'input_set_armory')
    if input_set_armory
        and input_set_armory:enabled()
        and input_set_armory._values.on_executed[1]
    then
        local police_toggle_off_id = input_set_armory._values.on_executed[1].id
        local police_toggle_off = TheFixesLib.mission.getElementByIdAndName(police_toggle_off_id, 'police_called_OFF')
        if police_toggle_off and police_toggle_off._values.elements[1] then
            local police_called_id = police_toggle_off._values.elements[1]
            local police_called = managers.mission:get_element_by_id(police_called_id)
            if police_called then
                local police_called_2 = TheFixesLib.deep_clone(police_called)
                local pc2_id = TheFixesLib.mission:GetId()
                police_called_2._id = pc2_id
                police_called_2._editor_name = 'the_fixes_police_called_2'
                police_called_2:set_enabled(true)
                police_called._mission_script._elements[pc2_id] = police_called_2
                police_called._values.on_executed = {{ id = pc2_id, delay = 0 }}
                
                local police_called_2_OFF = {
                    class = 'ElementToggle',
                    module = 'CoreElementToggle',
                    editor_name = 'the_fixes_police_called_2_OFF',
                    id = TheFixesLib.mission:GetId(),
                    values = {
                        enabled = true,
                        toggle = 'off',
                        trigger_times = -1,
                        base_delay = 0,
                        elements = { pc2_id }, -- police_called_2
                        set_trigger_times = -1,
                        on_executed = {}
                    }
                }
                input_set_armory._values.on_executed[1] = { id = TheFixesLib.mission.lastId, delay = 0 }
                input_set_armory._mission_script:_create_elements({police_called_2_OFF})
            end
        end
    end
end
