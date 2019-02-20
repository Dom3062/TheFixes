TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.joker_skill_upgradestweak then
	-- Fix for the issue when '1 joker max' skill overrides '2 jokers max'
	local origfunc = UpgradesTweakData.init
	function UpgradesTweakData:init(...)
		origfunc(self, ...)
		if self.definitions.player_convert_enemies_max_minions_1 then
			self.definitions.player_convert_enemies_max_minions_1.the_fixes_next = 'player_convert_enemies_max_minions_2'
			self.definitions.player_convert_enemies_max_minions_1.the_fixes_next_identifier = 'SkillTree_cable_guy'
		end
	end
end