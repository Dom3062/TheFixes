local TheFixes = TheFixes or {}
if TheFixes._hooks.CopDamage then
	return
else
	TheFixes._hooks.CopDamage = true
end

TheFixesPreventer = TheFixesPreventer or {}
local level_id = Global and Global.game_settings and Global.game_settings.level_id or "branchbank"
local function FailAchievement(id)
	AchievmentManager.the_fixes_failed = AchievmentManager.the_fixes_failed or {}
	AchievmentManager.the_fixes_failed[id] = true
	managers.mission:call_global_event("TheFixes_AchievementFailed", id)
end

if not TheFixesPreventer.achi_masterpiece and level_id == "gallery" then
	-- Fix for 'Masterpiece' achievement
	local key = "TheFixes_ArtGallery_Masterpiece"
	CopDamage.register_listener(key, { "on_damage" }, function(damage_info)
		if damage_info and damage_info.result.type == "death" then
			FailAchievement("cac_19")
			CopDamage.unregister_listener(key)
		end
	end)
end

if not TheFixesPreventer.achi_matrix_with_lasers and level_id == "big" then
	-- Fix for 'Matrix with lasers' achievement
	local origfunc = CopDamage._on_damage_received
	function CopDamage:_on_damage_received(damage_info, ...)
		if damage_info.result.type == "death" and self._unit:base().has_tag and self._unit:base():has_tag("sniper") then
			FailAchievement("cac_22")
		end
		return origfunc(self, damage_info, ...)
	end
end

if not TheFixesPreventer.crits_in_stealth then
	-- Fix for crits in stealth
	local roll_crit_orig = CopDamage.roll_critical_hit
	function CopDamage:roll_critical_hit(attack_data, ...)
		if self._unit:movement():cool() then
			attack_data.damage = self._HEALTH_INIT
		end

		return roll_crit_orig(self, attack_data, ...)
	end
end