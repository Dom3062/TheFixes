TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.mute_contractor_fixes then
    for i = 103882, 103884, 1 do
        local element = managers.mission:get_element_by_id(i)
        if element then
            element._values.can_not_be_muted = true
        end
    end
end