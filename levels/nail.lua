TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.mute_contractor_fixes then
    for _, id in ipairs({100120, 100123, 100135, 100136, 100137, 100138, 100139, 100144, 100163}) do
        local element = managers.mission:get_element_by_id(id)
        if element then
            element._values.can_not_be_muted = true
        end
    end
end