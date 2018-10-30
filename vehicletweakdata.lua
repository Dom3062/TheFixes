local origfunc = VehicleTweakData.init
function VehicleTweakData:init(...)
	origfunc(self, ...)
	
	if self.blackhawk_1 then
		self.blackhawk_1.damage = self.blackhawk_1.damage or {}
		self.blackhawk_1.damage.max_health = 9e+27
	end
end