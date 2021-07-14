TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_set_jammed_timergui then

    local set_jammed_orig = TimerGui._set_jammed
    function TimerGui:_set_jammed(...)
        if not (self._time_left or self._current_timer) then
            return
        end

        return set_jammed_orig(self, ...)
    end
    
end