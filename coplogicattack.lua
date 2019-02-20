TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_upd_aim_coplogicattack then
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
end

if not TheFixesPreventer.crash_aim_allow_fire_coplogicattack then
	-- coplogicattack.lua:1259: attempt to index field 'chatter' (a nil value)
	local aim_allow_fire_orig = CopLogicAttack.aim_allow_fire
	function CopLogicAttack.aim_allow_fire(shoot, aim, data, ...)
		if shoot then
			data.char_tweak.chatter = data.char_tweak.chatter or {}
		end
		return aim_allow_fire_orig(shoot, aim, data, ...)
	end
end