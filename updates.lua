if Global.load_level then
	return
end

local TF = ModInstance or {}
local thisDir = TheFixes and TheFixes.ModPath or ModPath

local function ApplyPatch(path, pattern, replacement)
	local fi, _ = io.open(thisDir .. path, 'r')
	if fi then
		local data = fi:read("*all")
		fi:close()
		local newData, count = data:gsub(pattern, replacement)
		if count and count > 0 then
			local fo, _ = io.open(thisDir .. path, 'w')
			if fo then
				fo:write(newData)
				fo:close()
			end
		end
	end
end

local function ProcessUpdateInfo(data)
	if type(data) == 'table' then
		-- Announcement
		if type(data.the_fixes_message) == 'string' then
			TheFixesMessage = data.the_fixes_message

			if TheFixes and TheFixes.msg_func then
				TheFixes.msg_func()
			end
		end

		-- Force disable or enable fixes
		if type(data.the_fixes_preventer_override) == 'table' then
			local needSave = false
			local newOverride = {}
			local wasNotEmpty = next(TheFixesPreventerOverride or {}) ~= nil
			for k, v in pairs(data.the_fixes_preventer_override) do
				if (TheFixesPreventer[k] or false) ~=  (v or false) then
					newOverride[k] = v or false
					needSave = true
				end
			end
			needSave = needSave or (wasNotEmpty and next(data.the_fixes_preventer_override) == nil)
			if needSave and MenuCallbackHandler and MenuCallbackHandler.the_fixes_save then
				TheFixesPreventerOverride = newOverride
				MenuCallbackHandler:the_fixes_save()
			end
		end

		-- Disable other mods by name
		if type(data.the_fixes_control_mods) == 'table' and BLT and BLT.Mods and BLT.Mods.GetModByName then
			for k, v in pairs(data.the_fixes_control_mods) do
				local mod = BLT.Mods:GetModByName(k)
				if mod and mod.SetEnabled and type(v) == 'boolean' then
					mod:SetEnabled(v)
				end
			end
		end

		-- Apply patches
		-- Every time something is patched, mod.txt and updates.lua must be also patched to point to a different info.json
		if type(data.the_fixes_patch) == 'table' then
			for k, v in ipairs(data.the_fixes_patch) do
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
end

if TF.HasUpdates and TF:HasUpdates() then
	local f = {}
	local updates = TF:GetUpdates()
	for i, update in ipairs(updates) do
		f[i] = update.clbk_got_update_data
		update.clbk_got_update_data = function(self, ...)
			local ret = f[i](self, ...)
			ProcessUpdateInfo(self._update_data)
			return ret
		end
	end
else
	local url = 'https://www.dropbox.com/s/0z0qdjqumi1iq7f/meta.json?raw=1'
	local fi, err = io.open(thisDir .. 'mod.txt', 'r')
	if fi then
		local data = fi:read("*all")
		fi:close()
		if not data:find(url) then
			assert(data:match(url:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%0")), 'Info URL in updates.lua does not match the one in mod.txt')
		end
	end
	dohttpreq(url, function(json_data, http_id, request_info)
		if request_info.querySucceeded and not string.is_nil_or_empty(json_data) then
			local data = json.decode(json_data)
			if type(data) == 'table' then
				for k, v in pairs(data) do
					ProcessUpdateInfo(v)
				end
			end
		end
	end)
end