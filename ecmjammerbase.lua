TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.ecm_feedback_position_client then
	-- Make ECM feedback always be around the ECM itself
	local origfunc = ECMJammerBase.spawn
	function ECMJammerBase.spawn(pos, rot, battery_life_upgrade_lvl, owner, ...)
		local newpos = owner and owner:position() or pos
		return origfunc(newpos, rot, battery_life_upgrade_lvl, owner, ...)
	end
end