TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_give_dmg_explosionman then
	local detect_give_dmg = ExplosionManager.detect_and_give_dmg
	function ExplosionManager:detect_and_give_dmg(...)
		local res1, res2, res3 = detect_give_dmg(self, ...)
		res3 = res3 or {}
		
		return res1, res2, res3
	end
end