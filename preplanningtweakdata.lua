local original = PrePlanningTweakData.init
function PrePlanningTweakData:init(...)
	original(self, ...)
	self.locations.branchbank.mission_briefing_texture = "guis/textures/pd2/pre_planning/mission_briefing_branchbank"
	self.locations.firestarter_3.mission_briefing_texture = "guis/textures/pd2/pre_planning/mission_briefing_branchbank"
end