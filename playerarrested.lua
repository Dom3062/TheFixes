TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_call_teammate_playerarrested then
	local origfunc = PlayerArrested.call_teammate
	function PlayerArrested:call_teammate(line, t, no_gesture, skip_alert, skip_mark_cop, ...)
		local vt, plural, prime_target = self:_get_unit_intimidation_action(true, false, true, true, false)

		if vt == "come" or (vt == "mark_cop" and not skip_mark_cop) then
			if not (prime_target and prime_target.unit) then
				return
			end

			if vt == "mark_cop" and not tweak_data.character[prime_target.unit:base()._tweak_table] then
				return
			end
		end

		origfunc(self, line, t, no_gesture, skip_alert, skip_mark_cop, ...)
	end
end