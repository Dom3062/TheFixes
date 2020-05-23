TheFixesPreventer = TheFixesPreventer or {}
if TheFixesPreventer.heist_undercover_softlock then
	return
end

-- https://steamcommunity.com/app/218620/discussions/14/2261313417693609920/

if Network:is_client() then
	return
end

local elem1 = managers.mission:get_element_by_id(102013)
if elem1 and elem1._values.base_delay and elem1._values.base_delay < 2 then
	elem1._values.base_delay = 2
end

local elem2 = managers.mission:get_element_by_id(102014)
if elem2 and elem2._values.base_delay and elem2._values.base_delay < 2 then
	elem2._values.base_delay = 2
end
