TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_machinegunbeltmanager_amplitude then
    -- Fixes https://steamcommunity.com/app/218620/discussions/14/3421068324008261803/
    local orig = MachineGunBeltManager.add_weapon
    function MachineGunBeltManager:add_weapon(weapon_unit, ...)
        orig(self, weapon_unit, ...)
        local entry = self._weapons[weapon_unit:key()]
        if entry and not entry.amplitude then
            entry.amplitude = 0
        end
    end
end