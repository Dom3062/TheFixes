TheFixesPreventer = TheFixesPreventer or {}


-- 'The Red Button' achievement description
-- Infamy achievements description
-- 'Euro bag simulator' achievements description
-- 'Spooky Pumpkin' trophy description
local origfunc = LocalizationManager.init
function LocalizationManager:init(...)
	origfunc(self, ...)
	
	TheFixesPreventer = TheFixesPreventer or {}
	
	if not TheFixesPreventer.achi_red_button_localeman then
	LocalizationManager:add_localized_strings({
		achievement_des_9_desc = self:text('achievement_des_9_desc')..' (OVERKILL+)'
	})
	end
	
	if not TheFixesPreventer.trophy_spooky_pumpkin_localeman then
	LocalizationManager:add_localized_strings({
		trophy_spooky_objective = self:text('trophy_spooky_objective')..' (HOST ONLY)'
	})
	end
end