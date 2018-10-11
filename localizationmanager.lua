-- string_id=nil fix
local text_original = LocalizationManager.text
function LocalizationManager:text(string_id, ...)
	if not string_id then string_id = 'NIL' end
	return text_original(self, string_id, ...)
end


-- 'The Red Button' achievement description
local origfunc = LocalizationManager.init
function LocalizationManager:init(...)
	origfunc(self, ...)
	LocalizationManager:add_localized_strings({
		achievement_des_9_desc = self:text('achievement_des_9_desc')..' (OVERKILL+)'
	})
end