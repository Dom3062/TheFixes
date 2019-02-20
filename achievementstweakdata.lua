TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.achi_prison_rules then
	-- Fix for 'Prison Rules, Bitch' achievement working on any heist
	local origfunc = AchievementsTweakData.init
	function AchievementsTweakData:init(...)
		origfunc(self, ...)
		
		self.enemy_melee_hit_achievements.bph_9.job = 'bph'
	end
end