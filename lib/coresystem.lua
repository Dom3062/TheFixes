TheFixesLib = TheFixesLib or {}

local loadstring = loadstring or load

local to_load = {
	utf8_validator = 'utf8_validator.lua',
    deep_clone = 'deep_clone.lua',
    mission = 'mission.lua'
}

local thisDir
local function Dirs()
	local thisPath = debug.getinfo(2, "S").source:sub(2)
	thisDir = string.match(thisPath, '.*/')
end
Dirs()
Dirs = nil

for k, v in pairs(to_load) do
	local filename = thisDir..v
	local f,err = io.open(filename, 'r')
	if f then
		local code = loadstring(f:read("*all"))
		f:close()
		
		if code then
			TheFixesLib[k] = code()
		else
			log("[The Fixes] Failed to load file: "..filename)
		end
	else
		log("[The Fixes] File not found: "..filename)
	end
end
