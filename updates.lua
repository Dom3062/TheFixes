
if HuskPlayerMovement then return end

if not BLT or not BLTUpdate then
	return	
end

-- If no blt or something then download and parse the info on our own

local info_saved = false
local got_upd_data_orig = BLTUpdate.clbk_got_update_data
function BLTUpdate:clbk_got_update_data(...)
	local ret = got_upd_data_orig(self, ...)

	if self.GetId and self:GetId() == 'the_fixes' then
		if type(self._update_data) == 'table' then
			-- Announcement
			if type(self._update_data.the_fixes_message) == 'string' then
				TheFixesMessage = self._update_data.the_fixes_message
				
				if TheFixes and TheFixes.msg_func then
					TheFixes.msg_func()
				end
			end

			-- Force disable or enable fixes
			if type(self._update_data.the_fixes_preventer_override) == 'table' then
				local needSave = false
				local newOverride = {}
				local wasNotEmpty = next(TheFixesPreventerOverride or {}) ~= nil
				for k, v in pairs(self._update_data.the_fixes_preventer_override) do
					if (TheFixesPreventer[k] or false) ~=  (v or false) then
						newOverride[k] = v or false
						needSave = true
					end
				end
				needSave = needSave or (wasNotEmpty and next(self._update_data.the_fixes_preventer_override) == nil)
				if needSave and MenuCallbackHandler and MenuCallbackHandler.the_fixes_save then
					TheFixesPreventerOverride = newOverride
					MenuCallbackHandler.the_fixes_save()
				end
			end

			-- Disable other mods by name
			if type(self._update_data.the_fixes_control_mods) == 'table' and BLT.Mods then
				for k, v in pairs(self._update_data.the_fixes_control_mods) do
					local mod = BLT.Mods:GetModByName(k)
					if mod and mod.SetEnabled and type(v) == 'boolean' then
						mod:SetEnabled(v)
					end
				end
			end
		end

		if not info_saved and TheFixes and TheFixes.dump_info and BLT.Mods then
			TheFixes.dump_info()
			info_saved = true
		end
	end

	return ret
end