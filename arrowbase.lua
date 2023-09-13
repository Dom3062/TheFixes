TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.throwable_falls_off_camera then
    -- Make throwables fall down after hitting cameras
    local orig = ArrowBase._attach_to_hit_unit
    function ArrowBase:_attach_to_hit_unit(...)
        if self._col_ray.unit then
            for _, u in ipairs(SecurityCamera.cameras or {}) do
                if u == self._col_ray.unit then
                    self._col_ray.unit = nil
                    break
                end
            end
        end

        return orig(self, ...)
    end
end