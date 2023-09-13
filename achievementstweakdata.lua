local original = AchievementsTweakData.init
function AchievementsTweakData:init(...)
    original(self, ...)
    if self.complete_heist_achievements and self.complete_heist_achievements.daily_classics and self.complete_heist_achievements.daily_classics.jobs then
        -- https://steamcommunity.com/app/218620/discussions/14/3836549485423172127/
        -- No Mercy is not counted in "A Trip Down Memory Lane" Side Job
        if self.complete_heist_achievements.daily_classics and self.complete_heist_achievements.daily_classics.jobs then
            self.complete_heist_achievements.daily_classics.jobs[#self.complete_heist_achievements.daily_classics.jobs + 1] = "nmh"
        end
        if self.complete_heist_achievements.challenge_srtd then
            self.complete_heist_achievements.challenge_srtd.everyone_weapons_used = { "sentry_gun", "sentry_gun_silent" }
        end
    end
end