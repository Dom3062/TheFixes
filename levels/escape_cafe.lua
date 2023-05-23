TheFixesPreventer = TheFixesPreventer or {}
if TheFixesPreventer.heist_escape_cafe_bag_not_counted then
	return
end

--https://steamcommunity.com/app/218620/discussions/14/3834297051382791123

local broken_loot_bag = managers.mission:get_element_by_id(100780) -- ´point_loot_bag_040´ ElementLootBag 100780
local bag_trigger = managers.mission:get_element_by_id(101418) -- ´spawning_bag_checker´ ElementLootBagTrigger 101418
if broken_loot_bag and bag_trigger then
    broken_loot_bag:add_trigger(bag_trigger._id, bag_trigger._values.trigger_type, callback(bag_trigger, bag_trigger, "on_executed"))
end