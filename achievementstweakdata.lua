local original = AchievementsTweakData.init
function AchievementsTweakData:init(...)
    original(self, ...)
    if self.complete_heist_achievements and self.complete_heist_achievements.challenge_srtd then
        self.complete_heist_achievements.challenge_srtd.everyone_weapons_used = { "sentry_gun", "sentry_gun_silent" }
    end
end