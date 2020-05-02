TheFixesPreventer = TheFixesPreventer or {}
if TheFixesPreventer.heist_diamond_heist_softlock then
	return
end

-- https://steamcommunity.com/app/218620/discussions/14/2261313417685797804/

if Network:is_client() then
	return
end

local elem = managers.mission:get_element_by_id(103920)
if elem then
	elem._values.enabled = false
end
