TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_mission_preset_groupaitweak then
	local read_mis_preset_orig = GroupAITweakData._read_mission_preset
    function GroupAITweakData:_read_mission_preset(tweak_data, ...)
        if Global.game_settings and Global.game_settings.level_id and tweak_data.levels[Global.game_settings.level_id] then
            read_mis_preset_orig(self, tweak_data, ...)
        end
    end
end

if not TheFixesPreventer.fix_gensec_shotgunner_in_murkywater then
    local _init_unit_categories = GroupAITweakData._init_unit_categories
    function GroupAITweakData:_init_unit_categories(difficulty_index, ...)
        _init_unit_categories(self, difficulty_index, ...)
        if difficulty_index < 6 then
        elseif difficulty_index < 8 then -- Death Wish
            self.unit_categories.FBI_heavy_R870.unit_types.murkywater =
            {
                Idstring("units/pd2_dlc_bph/characters/ene_murkywater_heavy_shotgun/ene_murkywater_heavy_shotgun")
            }
        else
        end
    end
end