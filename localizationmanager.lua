-- string_id=nil fix
local text_original = LocalizationManager.text
function LocalizationManager:text(string_id, ...)
	if not string_id then string_id = 'NIL' end
	return text_original(self, string_id, ...)
end


-- 'The Red Button' achievement description
-- Infamy achievements description
-- 'Euro bag simulator' achievements description
-- 'Say Hello to My Big Friend' achievements description
local origfunc = LocalizationManager.init
function LocalizationManager:init(...)
	origfunc(self, ...)
	LocalizationManager:add_localized_strings({
		achievement_des_9_desc = self:text('achievement_des_9_desc')..' (OVERKILL+)'
	})
	
	LocalizationManager:add_localized_strings({
		achievement_friend_4_desc = self:text('achievement_friend_4_desc')..' (OVERKILL+) (HOST ONLY)'
	})
	
	local infamy_strs = {}
	for i=1, 25 do
		infamy_strs['achievement_ignominy_'..i..'_desc'] = 'Reach Infamy '..i
	end
	LocalizationManager:add_localized_strings(infamy_strs)
	
	LocalizationManager:add_localized_strings({
		achievement_cane_3_unlock = self:text('achievement_cane_3_unlock'):gsub('Rudolph','Rudelf')
	})
	
	LocalizationManager:add_localized_strings({
		trophy_spooky_objective = self:text('trophy_spooky_objective')..' (HOST ONLY)'
	})
end