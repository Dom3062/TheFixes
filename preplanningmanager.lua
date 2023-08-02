TheFixesPreventer = TheFixesPreventer or {}

if not TheFixesPreventer.crash_get_elem_by_type_index_preplanman then
    -- Most likely a modding issue
    -- [string "lib/managers/preplanningmanager.lua"]:1005: attempt to index a nil value
    -- show_confirm_preplanning_rebuy() lib/managers/menumanagerdialogs.lua:1589
    -- open_rebuy_menu() lib/managers/preplanningmanager.lua:56
    -- on_preplanning_open() lib/managers/preplanningmanager.lua:42
    local get_elem_by_type_inx_orig = PrePlanningManager.get_element_name_by_type_index
    function PrePlanningManager:get_element_name_by_type_index(type, index, ...)
        if self._mission_elements_by_type
            and self._mission_elements_by_type[type]
            and self._mission_elements_by_type[type][index]
            and self._mission_elements_by_type[type][index].editor_name
        then
            return get_elem_by_type_inx_orig(self, type, index, ...)
        end
        return '???'
    end
end
