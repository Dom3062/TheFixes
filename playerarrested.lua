local origfunc = PlayerArrested.call_teammate
function PlayerArrested:call_teammate(...)
	local vt, plural, prime_target = self:_get_unit_intimidation_action(true, false, true, true, false)
	
	if not prime_target and (vt == 'come' or vt == 'mark_cop') then
		return
	end
	
	origfunc(self, ...)
end