TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_landing_done_vithelisync then
	local landing_done_orig = VitHelicopterSync.on_landing_done
	function VitHelicopterSync:on_landing_done(...)
		if not managers.player:player_unit() then return end
		return landing_done_orig(self, ...)
	end
end