TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.mute_contractor_fixes then
    -- Valve
    for i = 103925, 103933, 1 do
        local element = managers.mission:get_element_by_id(i)
        if element then
            element._values.can_not_be_muted = true
        end
    end
    -- Valve reminder
    do
        local element = managers.mission:get_element_by_id(103933)
        if element then
            element._values.can_not_be_muted = true
        end
    end
    for i = 103942, 103948, 1 do
        local element = managers.mission:get_element_by_id(i)
        if element then
            element._values.can_not_be_muted = true
        end
    end
end