local original = WeaponFactoryTweakData.init
function WeaponFactoryTweakData:init(tweak_data, ...)
    original(self, tweak_data, ...)
    if not self.wpn_fps_snp_msr_npc then
        return
    end
    -- Forces to use correct third person model for Rattlesnake sniper rifle
    self.wpn_fps_snp_msr_npc.unit = "units/pd2_dlc_gage_snp/weapons/wpn_fps_snp_msr/wpn_fps_snp_msr_npc"
end