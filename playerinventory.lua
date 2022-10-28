TheFixesPreventer = TheFixesPreventer or {}
if TheFixesPreventer.crash_PECM_sync then
    return
end

function PlayerInventory:_start_jammer_effect_drop_in_load(jammer_data)
	self:_start_jammer_effect(jammer_data.t)
end

function PlayerInventory:_start_feedback_effect_drop_in_load(jammer_data)
	self:_start_feedback_effect(jammer_data.t)
end