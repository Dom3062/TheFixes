
if HuskPlayerMovement then return end

if not BLT or 
	not BLT.Mods or
	not BLT.Mods.mods or
	not BLTUpdate or
	not BLT.Downloads or 
	not BLT.Downloads._downloads then
	return	
end

local info_saved = false
local run_upd_chk_orig = BLT.Mods._RunAutoCheckForUpdates
BLT.Mods._RunAutoCheckForUpdates = function(...)
	run_upd_chk_orig(...)
	
	if not BLTplus then
		CompareVersion()
	end
	
	if not info_saved and TheFixes and TheFixes.dump_info then
		TheFixes.dump_info()
		info_saved = true
	end
end


-- If no blt or something then download and parse the info on our own


local got_upd_data_orig = BLTUpdate.clbk_got_update_data
function BLTUpdate:clbk_got_update_data(...)
	local ret = got_upd_data_orig(self, ...)

	if self.GetId and self:GetId() == 'the-fixes' then
		if self._update_data and type(self._update_data) == 'table' then
			if self._update_data.the_fixes_message and type(self._update_data.the_fixes_message) == 'string' then
				TheFixesMessage = self._update_data.the_fixes_message
				
				if TheFixes and TheFixes.msg_func then
					TheFixes.msg_func()
				end
			end
		end
	end

	return ret
end