TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_str_nil_localeman then
	-- string_id=nil fix
	local text_original = LocalizationManager.text
	function LocalizationManager:text(string_id, ...)
		if not string_id then string_id = 'NIL' end
		return text_original(self, string_id, ...)
	end
end


-- 'The Red Button' achievement description
-- Infamy achievements description
-- 'Euro bag simulator' achievements description
-- 'Say Hello to My Big Friend' achievements description
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
	
	if not TheFixesPreventer.achi_hello_big_friend_localeman then
	LocalizationManager:add_localized_strings({
		achievement_friend_4_desc = self:text('achievement_friend_4_desc')..' (OVERKILL+) (HOST ONLY)'
	})
	end
	
	if not TheFixesPreventer.achi_infamy_localeman then
		local infamy_strs = {}
		for i=1, 25 do
			infamy_strs['achievement_ignominy_'..i..'_desc'] = 'Reach Infamy '..i
		end
		LocalizationManager:add_localized_strings(infamy_strs)
	end
	
	if not TheFixesPreventer.achi_euro_bag_sim_localeman then
	LocalizationManager:add_localized_strings({
		achievement_cane_3_unlock = self:text('achievement_cane_3_unlock'):gsub('Rudolph','Rudelf')
	})
	end
	
	if not TheFixesPreventer.achi_big_brother_localeman then
		if not self:text('achievement_vit_10_desc'):match('OVERKILL') then
			LocalizationManager:add_localized_strings({
				achievement_vit_10_desc = self:text('achievement_vit_10_desc')..' (OVERKILL+)'
			})
		end
	end
	
	if not TheFixesPreventer.trophy_spooky_pumpkin_localeman then
	LocalizationManager:add_localized_strings({
		trophy_spooky_objective = self:text('trophy_spooky_objective')..' (HOST ONLY)'
	})
	end
end