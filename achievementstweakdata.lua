local original = AchievementsTweakData.init
function AchievementsTweakData:init(tweak_data, ...)
    original(self, tweak_data, ...)
    if not self.enemy_kill_achievements then
        return
    end
    if self.enemy_kill_achievements.surprise_motherfucker then
        --Surprise Motherfucker
        --Kill 10 Bulldozers using only the Thanatos .50 cal sniper rifle. Unlocks the "CQB Barrel" for the Thanatos .50 cal sniper rifle.
        self.enemy_kill_achievements.surprise_motherfucker.enemy = nil
        self.enemy_kill_achievements.surprise_motherfucker.enemy_tags_any = { "tank" }
    end
    if self.enemy_kill_achievements.bang_for_buck then
        --Bang for the Buck
        --Kill 10 Bulldozers using any shotgun and 000 buckshot ammo. Unlocks the "Long Barrel" for the Street Sweeper shotgun, "Steven" mask, "Sparks" material and "Chief" pattern.
        self.enemy_kill_achievements.bang_for_buck.enemy = nil
        self.enemy_kill_achievements.bang_for_buck.enemy_tags_any = { "tank" }
    end
end