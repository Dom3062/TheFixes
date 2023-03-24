TheFixesPreventer = TheFixesPreventer or {}
if TheFixesPreventer.heist_hox_2 then
	return
end

if Network:is_client() then
	return
end

-- Fixes a possible softlock in Forensics if one of the players disconnected due to desync and had evidence
local elem = managers.mission:get_element_by_id(101351) -- ´remove_random_surplus´ ElementRandom 101351
if elem then
    table.insert(elem._values.on_executed, { id = 100005, delay = 0 })
end