TheFixesPreventer = TheFixesPreventer or {}

-- 'Spooky Pumpkin' trophy description
-- BM_GLOBAL_VALUE_MXM (McShay Mod Pack)
-- BM_GLOBAL_VALUE_PXP1 (McShay Weapon Pack 1)
-- BM_GLOBAL_VALUE_PXP2 (McShay Weapon Pack 2)
-- BM_GLOBAL_VALUE_PXP3 (McShay Weapon Pack 3)
-- BM_GLOBAL_VALUE_XM22 (Criminal Carol 2022)
local origfunc = LocalizationManager.init
function LocalizationManager:init(...)
	origfunc(self, ...)

	TheFixesPreventer = TheFixesPreventer or {}

	if not TheFixesPreventer.trophy_spooky_pumpkin_localeman then
	LocalizationManager:add_localized_strings({
		trophy_spooky_objective = self:text('trophy_spooky_objective')..' (HOST ONLY)'
	})

	LocalizationManager:add_localized_strings({
		bm_global_value_mxm = "McShay Mod Pack",
		bm_global_value_pxp1 = "McShay Weapon Pack 1",
		bm_global_value_pxp2 = "McShay Weapon Pack 2",
		bm_global_value_pxp3 = "McShay Weapon Pack 3",
		bm_global_value_xm22 = "Criminal Carol 2022"
	})
	end
end