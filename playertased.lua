TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_check_act_shock_playertased then
    local check_act_shock_orig = PlayerTased._check_action_shock
    function PlayerTased:_check_action_shock(...)
        self._next_shock = self._next_shock or 0.5
        return check_act_shock_orig(self, ...)
    end
end
