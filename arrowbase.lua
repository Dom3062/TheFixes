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

local _attach_to_hit_unit = ArrowBase._attach_to_hit_unit
function ArrowBase:_attach_to_hit_unit(...)
    _attach_to_hit_unit(self, ...)
    local unit = self._col_ray.unit
    if alive(unit) then
        local hit_base = unit:base()
        -- Exact copy of achievement check
        if hit_base and (hit_base._tweak_table == "tank_medic" or hit_base._tweak_table == "tank_mini") and alive(self:weapon_unit()) and self:weapon_unit():base():is_category(tweak_data.achievement.pincushion.weapon_category) then
            hit_base._num_attached_arrows = (hit_base._num_attached_arrows or 0) + 1
            if hit_base._num_attached_arrows == tweak_data.achievement.pincushion.count then
                managers.achievment:award(tweak_data.achievement.pincushion.award)
            end
        end
    end
end