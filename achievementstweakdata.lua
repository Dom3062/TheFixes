local original = AchievementsTweakData.init
function AchievementsTweakData:init(...)
    original(self, ...)
    if self.enemy_kill_achievements then
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
    if self.visual and self.visual.cac_1 and self.visual.cac_1.tags and self.tags and self.tags.inventory then
        -- https://steamcommunity.com/app/218620/discussions/14/3836549485407993681/
        -- Compact Confrontation
        -- Kill a Sniper from a distance of 40 meters with the Compact 40mm Grenade Launcher.
        for i, tag in ipairs(self.visual.cac_1.tags) do
            if tag == self.tags.inventory.mask then
                self.visual.cac_1.tags[i] = self.tags.inventory.weapon
            end
        end
    end
end