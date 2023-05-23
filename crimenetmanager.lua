TheFixesPreventer = TheFixesPreventer or {}

if not TheFixesPreventer.crimenet_fix_wrapped_jobs_with_no_date then
    local original_get_last_played_job = CrimeNetManager.get_last_played_job
    function CrimeNetManager:get_last_played_job(job_id, ...)
        local job_data = tweak_data.narrative:job_data(job_id, true)
        if type(job_data) == "table" and type(job_data.job_wrapper) == "table" and next(job_data.job_wrapper) then -- This job is wrapped (has day variations)
            -- Loop over them and find out which wrapped job was played last, we will return this one
            local highest_date = 0
            for _, wrapped_job in ipairs(job_data.job_wrapper) do
                local wrapped_job_stats = self._global.broker.stats[wrapped_job] or {}
                local date = wrapped_job_stats.last_played_date or {}
                local date_value = date._value or 0
                -- Value is numerical representation of the date, we will use this value because it is faster to check if the date is newer or not; see DateTime in Lua decomp
                if date_value > highest_date then
                    -- Overwrite provided job_id with our wrapped job so the last played date will show correctly
                    highest_date = date_value
                    job_id = wrapped_job
                end
            end
        end
        return original_get_last_played_job(self, job_id, ...)
    end
end