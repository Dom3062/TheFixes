TheFixesPreventer = TheFixesPreventer or {}
if TheFixesPreventer.crash_invalid_perkdeck then
    return
end

local _f_get_specialization_value = SkillTreeManager.get_specialization_value
function SkillTreeManager:get_specialization_value(...)
    local value = self._global.specializations
    if value then
        return _f_get_specialization_value(self, ...)
    end
    return 0 -- Fallback to 0 when value is nil (maybe custom perk deck or no deck at all ???)
end