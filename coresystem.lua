TheFixes = TheFixes or {
	fire_dot = true,
	shotgun_dozer_face = true,
	gambler = true,
	dozers_counting = true,
	shotgun_turret = true,
	cops_reload = true,
	instant_quit = true,
	last_msg_id = '',
	language = 1
}

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
