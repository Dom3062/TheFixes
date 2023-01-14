TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_charmmanager_missing_player_camera_extension then
    local original = CharmManager.get_movement_data
    function CharmManager:get_movement_data(weapon, user, ...)
        if user then
            local base_ext = user:base()
            if base_ext and base_ext.is_local_player then
                if user:camera() then -- Camera extension is present, run original function because it won't crash
                    return original(self, weapon, user, ...)
                end
                -- Here in Vanilla, it will crash hard, so return default values; copy of the logic from the function itself
                local data = {
                    prev_weapon_rot = Rotation()
                }
                local movement = user:movement()
                if movement then
                    data.update_type = "simulate_ingame_upd_m"
                    data.user_unit = user
                    data.user_m_pos = movement:m_head_pos()
                    self:set_common_mov_data(weapon, data)
                else
                    data.update_type = "simulate_ingame_no_user"
                end
                return data
            end
        end
        return original(self, weapon, user, ...)
    end
end