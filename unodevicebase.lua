TheFixesPreventer = TheFixesPreventer or {}

if not TheFixesPreventer.crash_safehouse_unodevice then
    -- https://steamcommunity.com/app/218620/discussions/14/2275953283821675809
    -- 71: attempt to index a nil value
    local cycle_hints_orig = UnoDeviceBase.cycle_hints
	function UnoDeviceBase:cycle_hints(...)
        local uno_challenge = nil
        uno_challenge = managers.custom_safehouse:uno_achievement_challenge()
        
        if uno_challenge and uno_challenge:challenge() then
            cycle_hints_orig(self, ...)
        end
    end
end
