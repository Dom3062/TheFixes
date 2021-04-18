TheFixesPreventer = TheFixesPreventer or {}
if TheFixesPreventer.heist_white_house_secret then
	return
end

if Network:is_client() then
	return
end

local boomed_wall = managers.mission:get_element_by_id(102392)
local took_elevator = managers.mission:get_element_by_id(104052)
if boomed_wall and took_elevator then
	for i = #took_elevator._values.on_executed,1,-1 do
		took_elevator._values.on_executed[i+1] = took_elevator._values.on_executed[i]
	end
	took_elevator._values.on_executed[1] = { id = 102393, delay = 0 }
	boomed_wall._values.on_executed[1] = nil
end


if TheFixesPreventer.heist_white_house_murky_death then
	return
end

-- https://steamcommunity.com/app/218620/discussions/14/3110266679792256585/

if not managers.vehicle then
	return
end

local func_disable_unit_058 = managers.mission:get_element_by_id(104080)
if func_disable_unit_058 then
	local func_disable_unit_058_orig = func_disable_unit_058.on_executed
	func_disable_unit_058.on_executed = function(...)
		-- Fix from Iter
		for i = #managers.vehicle._vehicles, 1, -1 do
			if not alive(managers.vehicle._vehicles[i]) then
				table.remove(managers.vehicle._vehicles, i)
			end
		end
		func_disable_unit_058_orig(...)
	end
end
