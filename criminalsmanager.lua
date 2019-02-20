TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_char_data_nil_criminalsman then
	local static_by_name_orig = CriminalsManager.character_static_data_by_name
	function CriminalsManager:character_static_data_by_name(...)
		local res = static_by_name_orig(self, ...)
		
		if res then
			return res
		end
		
		return {
					voice = "rb4",
					ai_mask_id = "dallas",
					ai_character_id = "ai_dallas",
					ssuffix = "a"
				}
	end
end