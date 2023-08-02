-- https://steamcommunity.com/app/218620/discussions/14/3811783679201790912/

TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.mute_contractor_fixes then
    -- 100210 - 1775
    -- 101264 - hint: 1 at the beginning
    -- 101270 - hint: garret is married - 1212
    -- 101357 - same as 101264
    -- 101824 - 2015
    -- 101825 - hint: 2 at the beginning
    -- 101826 - hint: obvious; 1234
    -- 101827 - same as 101264
    -- 101835 - garret is coming back

    -- send e-mail
    -- 101517 - taylor
    -- 101837 - a. valentine
    -- 101838 - chloe
    -- 101839 - brown
    -- 101840 - taylor (reminder)
    -- 101841 - a. valentine (reminder)
    -- 101842 - chloe (reminder)
    -- 101843 - brown (reminder)
    for _, id in ipairs({100210, 101264, 101270, 101357, 101824, 101825, 101826, 101827, 101835, 101517, 101837, 101838, 101839, 101840, 101841, 101842, 101843}) do
        local element = managers.mission:get_element_by_id(id)
        if element then
            element._values.can_not_be_muted = true
        end
    end
end