local text_original = LocalizationManager.text
function LocalizationManager:text(string_id, ...)
	if not string_id then string_id = 'NIL' end
	return text_original(self, string_id, ...)
end