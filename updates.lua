
if HuskPlayerMovement then return end

if not BLT or not BLTUpdate or not BLTUpdate.clbk_got_update_data then
	return	
end

local thisPath
local thisDir
local upDir
local function Dirs()
	thisPath = debug.getinfo(2, "S").source:sub(2)
	thisDir = string.match(thisPath, '.*/')
	upDir = thisDir:match('(.*/).-/')
end
Dirs()
Dirs = nil

-- If no blt or something then download and parse the info on our own

local function ApplyPatch(path, pattern, replacement)
	local fi, err = io.open(thisDir .. path, 'r')
	if fi then
		local data = fi:read("*all")
		fi.close()
		local newData, count = data:gsub(pattern, replacement)
		if count and count > 0 then
			local fo, err = io.open(thisDir .. path, 'w')
			if fo then
				fo:write(newData)
			end
		end
	end
end

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

			-- Apply patches
			if type(self._update_data.the_fixes_patch) == 'table' then
				for k, v in ipairs(self._update_data.the_fixes_patch) do
					if type(v) == 'table'
						and type(v[1]) == 'string'
						and type(v[2]) == 'string'
						and type(v[3]) == 'string'
					then
						ApplyPatch(v[1], v[2], v[3])
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
