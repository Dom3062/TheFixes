TheFixesPreventer = TheFixesPreventer or {}
if TheFixesPreventer.heist_reservoir1_softlock then
	return
end

-- https://steamcommunity.com/app/218620/discussions/14/2245552086112646712/

if Network:is_client() then
	return
end

local elem = managers.mission:get_element_by_id(100507) -- disable_stuff_randomization005
if elem then
	if elem._values.elements and elem._values.elements[3] and elem._values.elements[3] == 101126 then -- enable_because_gate_is_open
        table.remove(elem._values.elements, 3)
    end
end
