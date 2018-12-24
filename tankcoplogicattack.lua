-- Make dozers walk when near heisters
local origfunc = TankCopLogicAttack._chk_request_action_walk_to_chase_pos
function TankCopLogicAttack._chk_request_action_walk_to_chase_pos(data, my_data, speed, ...)
	local run_dist = data.attention_obj.verified and 1500 or 800
	local walk = data.attention_obj.verified_dis < run_dist and (not TheFixes or TheFixes.dozers_walk)
	
	return origfunc(data, my_data, walk and 'walk' or speed, ...)
end