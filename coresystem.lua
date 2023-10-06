if TheFixes then
	return
end

TheFixes = {
	-- mods/The Fixes/
	ModPath = ModPath,
	fire_dot = true,
	gambler = true,
	cops_reload = true,
	instant_quit = true,
	last_msg_id = '',
	language = 1,
	_hooks = {},
	_cache = {}
}

function TheFixes:CheckHook(hook)
	if self._hooks[hook] then
		return true
	end
	self._hooks[hook] = true
	return false
end

function TheFixes:CheckLoadHook(hook)
	if not Global.load_level then
		return true
	end
	if self._hooks[hook] then
		return true
	end
	self._hooks[hook] = true
	return false
end

local function LoadSettings()
	local file = io.open(SavePath .. 'The Fixes.txt', "r")
	if file then
		for k, v in pairs(json.decode(file:read("*all")) or {}) do
			if TheFixes[k] ~= nil then
				TheFixes[k] = v
			elseif k == 'override' and type(v) == 'table' then
				TheFixesPreventer = TheFixesPreventer or {}
                TheFixesPreventerOverride = TheFixesPreventerOverride or {}
				for k2, v2 in pairs(v) do
					TheFixesPreventer[k2] = v2 or nil
                    TheFixesPreventerOverride[k2] = v2
				end
			end
		end
		file:close()
	end
end
LoadSettings()