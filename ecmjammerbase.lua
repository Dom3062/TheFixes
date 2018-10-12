-- Make ECM feedback always be around the ECM itself
local origfunc = ECMJammerBase._detect_and_give_dmg
function ECMJammerBase._detect_and_give_dmg(hit_pos, device_unit, user_unit, ...)
	ECMJammerBase.the_fixes_feedback_positions = ECMJammerBase.the_fixes_feedback_positions or {}
	local key = device_unit:key()
	if not ECMJammerBase.the_fixes_feedback_positions[key] then
		ECMJammerBase.the_fixes_feedback_positions[key] = user_unit:position() or Vector3(0, 0, 0)
	end
	origfunc(ECMJammerBase.the_fixes_feedback_positions[key], device_unit, user_unit, ...)
end