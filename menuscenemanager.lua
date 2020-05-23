TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_henchmen_pose_menuscene then
    local sel_hench_pose_orig = MenuSceneManager._select_henchmen_pose
    function MenuSceneManager:_select_henchmen_pose(unit, weapon_id, ...)
        tweak_data.weapon[weapon_id] = tweak_data.weapon[weapon_id] or {}
        tweak_data.weapon[weapon_id].categories = tweak_data.weapon[weapon_id].categories or {}
        tweak_data.weapon[weapon_id].categories[1] = tweak_data.weapon[weapon_id].categories[1] or '_unknown'
        
        return sel_hench_pose_orig(self, unit, weapon_id, ...)
    end
end
