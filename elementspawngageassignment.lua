local TheFixes = rawget(_G, "TheFixes")
if Network:is_client() or TheFixes:CheckLoadHook("ElementSpawnGageAssignment") then
    return
end
local TheFixesPreventer = rawget(_G, "TheFixesPreventer") or {}
if Global.game_settings.level_id == "hox_1" and not TheFixesPreventer.heist_hox_1 then
    local init = ElementSpawnGageAssignment.init
    function ElementSpawnGageAssignment:init(...)
        init(self, ...)
        local index = -1
        for i, element in ipairs(self._values.orientation_elements) do
            --´gage_point002´ MissionScriptElement 101303
            --      position -9125, -12575, -2400
            --      rotation 0, 0, 1, -1.19209E-07
            if element == 101303 then
                index = i
                break
            end
        end
        if index ~= -1 then
            table.remove(self._values.orientation_elements, index)
        end
    end
end