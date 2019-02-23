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