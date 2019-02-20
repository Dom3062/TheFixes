TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_pocket_ecm_playerinv then
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
end

if not TheFixesPreventer.crash_feedback_playerinv then
	-- Fix for a rare crash with self._feedback_interval=nil (shouldn't be 'self' at all)
	local origfunc2 = PlayerInventory._start_feedback_effect
	function PlayerInventory:_start_feedback_effect(end_time, interval, ...)
		self._feedback_interval = interval or 1.5
		
		return origfunc2(self, end_time, interval, ...)
	end
end