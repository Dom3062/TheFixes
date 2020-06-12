TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_upd_info_text_crimespreemis then
    -- 781: attempt to compare nil with number
    -- https://steamcommunity.com/app/218620/discussions/14/2290590708547322595/
    local upd_info_text_orig = CrimeSpreeMissionButton.update_info_text
	function CrimeSpreeMissionButton:update_info_text(mission_data, ...)
        mission_data = mission_data or self._mission_data
        if not mission_data.add then
            managers.crime_spree:reset_crime_spree()
            managers.savefile:save_progress()
        end
        return upd_info_text_orig(self, mission_data, ...)
    end
end