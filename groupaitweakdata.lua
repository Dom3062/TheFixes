TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_mission_preset_groupaitweak then
	local read_mis_preset_orig = GroupAITweakData._read_mission_preset
    function GroupAITweakData:_read_mission_preset(tweak_data, ...)
        if Global.game_settings and Global.game_settings.level_id and tweak_data.levels[Global.game_settings.level_id] then
            read_mis_preset_orig(self, tweak_data, ...)
        end
    end
end
