TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.infinite_smoke then
	local origfunc = AmmoBagBase.take_ammo
	function AmmoBagBase:take_ammo(...)
		local res1,res2,res3,res4 = origfunc(self, ...)
		
		if self._ammo_amount and self._ammo_amount < 0.0006 then
			self:_set_empty()
			managers.network:session():send_to_peers_synched("sync_ammo_bag_ammo_taken", self._unit, 1)
		end
		
		return res1,res2,res3,res4
	end
end