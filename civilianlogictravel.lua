if BLT and BLT.Mods then
	local mods = BLT.Mods:Mods()
	for _, v in ipairs(mods) do
		if v.name and v.name:lower() == 'please, go there' then
			log('[The Fixes] CivilianLogicTravel disabled')
			return
		end
	end
end

TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.civvie_goes_to_player then
	-- Make civilians go straight to the player they are following
	local origfunc = CivilianLogicTravel._determine_exact_destination
	function CivilianLogicTravel._determine_exact_destination(data, objective, ...)
		if objective
			and objective.type == 'follow'
			and objective.follow_unit
		then
			return objective.follow_unit:movement():nav_tracker():field_position()
		end
		return origfunc(data, objective, ...)
	end
end