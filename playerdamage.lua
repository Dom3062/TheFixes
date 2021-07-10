TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_friendly_fire_playerdam then

    local is_friendly_fire_orig = PlayerDamage.is_friendly_fire
    function PlayerDamage:is_friendly_fire(unit, ...)
        if unit and unit:movement() then
            return is_friendly_fire_orig(self, unit, ...)
        end

        return false
    end

end
