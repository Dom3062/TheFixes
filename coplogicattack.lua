-- coplogicattack.lua:1080: attempt to index 'weapon_range' (a nil value)
local origfunc =  CopLogicAttack._upd_aim
function CopLogicAttack._upd_aim(data, my_data, ...)
	if data.attention_obj
		and AIAttentionObject.REACT_AIM <= data.attention_obj.reaction
		and (data.attention_obj.verified or data.attention_obj.nearly_visible)
		and not (my_data and my_data.weapon_range)
	then
		return
	end
	
	return origfunc(data, my_data, ...)
end