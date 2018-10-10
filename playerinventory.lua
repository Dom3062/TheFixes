local origfunc = PlayerInventory.get_jammer_time
function PlayerInventory:get_jammer_time(...)
	local upg_name = 'pocket_ecm_jammer_base'
			
	if self._unit:base():upgrade_value('player', upg_name) then
		local dur = origfunc(self, ...)
		if dur then return dur end
	end
	
	local td = tweak_data.upgrades.values.player[upg_name]
	return (td and td[1] and td[1].duration) and td[1].duration or 6
end