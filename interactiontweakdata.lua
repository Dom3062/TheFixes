local original = InteractionTweakData.init
function InteractionTweakData:init(...)
    original(self, ...)
    -- Fixes continuous interact generator sound when interrupted
    self.hold_generator_start.sound_interupt = "bar_water_pump_cancel"
end