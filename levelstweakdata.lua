local original = LevelsTweakData.init
function LevelsTweakData:init(...)
	original(self, ...)
	self.chill.ghost_bonus = nil
	self.spa.max_bags = 8
	self.fish.max_bags = 20
end