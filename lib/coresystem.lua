local Path = TheFixes and (TheFixes.ModPath .. "lib/") or (ModPath .. "lib/")
TheFixesLib = TheFixesLib or {}

local loadstring = loadstring or load

local to_load = {
	utf8_validator = 'utf8_validator.lua',
    deep_clone = 'deep_clone.lua',
    mission = 'mission.lua'
}

for k, v in pairs(to_load) do
	local filename = Path..v
	local f, _ = io.open(filename, 'r')
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
