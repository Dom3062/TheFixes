TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_get_spread_newnpcraycast then
    -- newnpcraycastweaponbase.lua"]:437: attempt to index local 'spread_values' (a number value) (modding issue)
    -- Crash in function NewNPCRaycastWeaponBase:_get_spread()
	local orig = NewNPCRaycastWeaponBase.init
	function NewNPCRaycastWeaponBase:init(...)
        orig(self, ...)
        local name_id = self:non_npc_name_id()
        local weapon_tweak = tweak_data.weapon[name_id]
        if weapon_tweak and not weapon_tweak.spread then
            tweak_data.weapon[name_id].spread = {}
        end
    end
end