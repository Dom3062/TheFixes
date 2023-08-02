local original = AchievementsTweakData.init
function AchievementsTweakData:init(...)
    original(self, ...)
    -- This needs to be fixed in ArrowBase too
    --[[if self.pincushion then
        -- Hedgehog
        -- Get 10 or more arrows stuck in a Bulldozer at the same time. Unlocks the "Lone Heister" mask, "Scorpion" material and "Totem" pattern.
        self.pincushion.enemy = nil
        self.pincushion.enemy_tags_any = { "tank" }
    end]]
    if self.grenade_achievements then
        if self.grenade_achievements.any_tank_kills then
            self.grenade_achievements.any_tank_kills.enemy = nil
            self.grenade_achievements.any_tank_kills.enemy_tags_any = { "tank" }
        end
        if self.grenade_achievements.trophy_special_kills and self.grenade_achievements.trophy_special_kills.enemies then
            local n = #self.grenade_achievements.trophy_special_kills.enemies
            self.grenade_achievements.trophy_special_kills.enemies[n + 1] = "tank_mini"
            self.grenade_achievements.trophy_special_kills.enemies[n + 2] = "tank_medic"
        end
    end
    if self.enemy_kill_achievements then
        if self.enemy_kill_achievements.surprise_motherfucker then
            -- Surprise Motherfucker
            -- Kill 10 Bulldozers using only the Thanatos .50 cal sniper rifle. Unlocks the "CQB Barrel" for the Thanatos .50 cal sniper rifle.
            self.enemy_kill_achievements.surprise_motherfucker.enemy = nil
            self.enemy_kill_achievements.surprise_motherfucker.enemy_tags_any = { "tank" }
        end
        if self.enemy_kill_achievements.bang_for_buck then
            -- Bang for the Buck
            -- Kill 10 Bulldozers using any shotgun and 000 buckshot ammo. Unlocks the "Long Barrel" for the Street Sweeper shotgun, "Steven" mask, "Sparks" material and "Chief" pattern.
            self.enemy_kill_achievements.bang_for_buck.enemy = nil
            self.enemy_kill_achievements.bang_for_buck.enemy_tags_any = { "tank" }
        end
        if self.enemy_kill_achievements.grind_fest then
            -- Precision Aiming
            -- Kill 25 Bulldozers using the Gewehr 3 Rifle. Unlocks the "Sniper Barrel" for the Clarion rifle, "Sniper Stock", "Sniper Grip" and "Sniper Foregrip" for the Gecko 7.62 rifle, "Precision Stock", "Precision Foregrip", "Precision Grip" and the "DMR Kit" for the Gewehr 3 rifle as well as the "Black Death" mask.
            self.enemy_kill_achievements.grind_fest.enemy = nil
            self.enemy_kill_achievements.grind_fest.enemy_tags_any = { "tank" }
        end
        if self.enemy_kill_achievements.any_tank_kills then
            self.enemy_kill_achievements.any_tank_kills.enemy = nil
            self.enemy_kill_achievements.any_tank_kills.enemy_tags_any = { "tank" }
        end
        if self.enemy_kill_achievements.trophy_special_kills and self.enemy_kill_achievements.trophy_special_kills.enemies then
            local n = #self.enemy_kill_achievements.trophy_special_kills.enemies
            self.enemy_kill_achievements.trophy_special_kills.enemies[n + 1] = "tank_mini"
            self.enemy_kill_achievements.trophy_special_kills.enemies[n + 2] = "tank_medic"
        end
        if self.enemy_kill_achievements.pim_3 and self.enemy_kill_achievements.pim_3.enemies then
            -- UMP for Me, UMP for You
            -- Kill 45 Russian specials on the Boiling Point job with the Jackal Submachine Gun on the OVERKILL difficulty or above. Unlocks the "Zashchita" mask, "Mist" material and "Battle Wounds" pattern.
            local n = #self.enemy_kill_achievements.pim_3.enemies
            self.enemy_kill_achievements.pim_3.enemies[n + 1] = "tank_mini"
            self.enemy_kill_achievements.pim_3.enemies[n + 2] = "tank_medic"
        end
        if self.enemy_kill_achievements.cg22_personal_3 and self.enemy_kill_achievements.cg22_personal_3.enemies then
            local n = #self.enemy_kill_achievements.cg22_personal_3.enemies
            self.enemy_kill_achievements.cg22_personal_3.enemies[n + 1] = "tank_mini"
            self.enemy_kill_achievements.cg22_personal_3.enemies[n + 2] = "tank_medic"
        end
        if self.enemy_kill_achievements.cg22_post_objective_5 then
            self.enemy_kill_achievements.cg22_post_objective_5.enemy = nil
            self.enemy_kill_achievements.cg22_post_objective_5.enemy_tags_any = { "tank" }
        end
        if self.enemy_kill_achievements.sentry_kills then
            self.enemy_kill_achievements.sentry_kills.attack_weapon_type = { weapon_1 = "sentry_gun", weapon_2 = "sentry_gun_silent" }
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
    if self.enemy_melee_hit_achievements then
        if self.enemy_melee_hit_achievements.are_you_kidding_me then
            -- Are You Kidding Me?
            -- Kill a Bulldozer in a knife fight.
            self.enemy_melee_hit_achievements.are_you_kidding_me.enemy = nil
            self.enemy_melee_hit_achievements.are_you_kidding_me.enemy_tags_any = { "tank" }
        end
        if self.enemy_melee_hit_achievements.knockout then
            -- Knockout!
            -- Knock out a Bulldozer using the OVERKILL boxing gloves. Unlocks "The Champ" mask.
            self.enemy_melee_hit_achievements.knockout.enemy = nil
            self.enemy_melee_hit_achievements.knockout.enemy_tags_any = { "tank" }
        end
        if self.enemy_melee_hit_achievements.any_tank_kills then
            self.enemy_melee_hit_achievements.any_tank_kills.enemy = nil
            self.enemy_melee_hit_achievements.any_tank_kills.enemy_tags_any = { "tank" }
        end
        if self.enemy_melee_hit_achievements.trophy_knockouts then
            -- Big Daddy
            -- Knock out 5 Bulldozers with the OVERKILL Boxing Gloves.
            self.enemy_melee_hit_achievements.enemies = nil
            self.enemy_melee_hit_achievements.enemy_tags_any = { "tank" }
        end
        if self.enemy_melee_hit_achievements.trophy_special_kills and self.enemy_melee_hit_achievements.trophy_special_kills.enemies then
            local n = #self.enemy_melee_hit_achievements.trophy_special_kills.enemies
            self.enemy_melee_hit_achievements.trophy_special_kills.enemies[n + 1] = "tank_mini"
            self.enemy_melee_hit_achievements.trophy_special_kills.enemies[n + 2] = "tank_medic"
        end
    end
end