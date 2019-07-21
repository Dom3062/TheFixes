TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_check_heat_jobman then
	local check_heat_orig = JobManager.check_add_heat_to_jobs
	function JobManager:check_add_heat_to_jobs(...)
		pcall(check_heat_orig, self, ...)
	end
end