-- Make ECM feedback always be around the ECM itself
local origfunc = ECMJammerBase._detect_and_give_dmg
function ECMJammerBase._detect_and_give_dmg(hit_pos, device_unit, user_unit, ...)
	local newpos = device_unit:position()
	if newpos then
		origfunc(newpos, device_unit, user_unit, ...)
	end
end