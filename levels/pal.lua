TheFixesPreventer = TheFixesPreventer or {}
if TheFixesPreventer.heist_counterfeit_softlock then
	return
end

-- https://steamcommunity.com/app/218620/discussions/14/2290590708528345140/

local choose_random_box = managers.mission:get_element_by_id(101383)
if choose_random_box then
	choose_random_box._values.base_delay = 0
end
