TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.shotguns_reloading_one_shell_only then
    local reload_fix_start_action_reload_enter = PlayerStandard._start_action_reload_enter
    function PlayerStandard:_start_action_reload_enter(...)
        local weapon = self._equipped_unit:base()
        if weapon and weapon._current_reload_speed_multiplier and weapon:can_reload() then
            weapon._current_reload_speed_multiplier = nil
        end
        reload_fix_start_action_reload_enter(self, ...)
    end
end