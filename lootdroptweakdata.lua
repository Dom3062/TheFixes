local original = LootDropTweakData.init
function LootDropTweakData:init(...)
	original(self, ...)
	self.global_values.complete_overkill_pack.hide_unavailable = true
end