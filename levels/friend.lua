TheFixesPreventer = TheFixesPreventer or {}
if TheFixesPreventer.heist_scarface_softlock then
	return
end

if Network:is_client() then
	return
end

local switch_objectives_2 = managers.mission:get_element_by_id(102767)
if switch_objectives_2 and switch_objectives_2._values and switch_objectives_2._values.on_executed then
    for k, v in pairs(switch_objectives_2._values.on_executed) do
        if v.id == 102768 and v.delay > 0 then
            switch_objectives_2._values.on_executed[k].delay = 0
            break
        end
    end
end
