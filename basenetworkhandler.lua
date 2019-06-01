TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_ver_char_send_basenetwork then
	local verify_char_send_orig = BaseNetworkHandler._verify_character_and_sender
	function BaseNetworkHandler._verify_character_and_sender(unit, rpc, ...)
		if not rpc then return false end
		if unit and not unit:character_damage() then return false end
		return verify_char_send_orig(unit, rpc, ...)
	end
end