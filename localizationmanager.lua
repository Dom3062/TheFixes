TheFixesPreventer = TheFixesPreventer or {}

-- 'Spooky Pumpkin' trophy description
local origfunc = LocalizationManager.init
function LocalizationManager:init(...)
	origfunc(self, ...)

	TheFixesPreventer = TheFixesPreventer or {}

	if not TheFixesPreventer.trophy_spooky_pumpkin_localeman then
	LocalizationManager:add_localized_strings({
		trophy_spooky_objective = self:text('trophy_spooky_objective')..' (HOST ONLY)'
	})
	end
end