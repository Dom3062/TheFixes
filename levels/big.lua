-- Fixes an exploit during transition from Stealth to Loud and XP is awarded for the second time
for i = 106174, 106178, 1 do
    if i ~= 106176 then -- Loot XP
        local element = managers.mission:get_element_by_id(i)
        if element then
            element:set_trigger_times(1)
        end
    end
end