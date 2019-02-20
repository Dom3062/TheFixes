TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_no_last_played_date_crimenetman then
	-- Because the original can return 0, which immediately gives 'attempt to index a number'
	local get_last_pl_orig = CrimeNetManager.get_last_played_job
	function CrimeNetManager:get_last_played_job(...)
		local res = get_last_pl_orig(self, ...)
		if type(res) ~= 'table' then
			return DateTime:new("now")
		end
		return res
	end
end