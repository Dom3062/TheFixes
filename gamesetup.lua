local thisDir
local function Dirs()
	local thisPath = debug.getinfo(2, "S").source:sub(2)
	thisDir = string.match(thisPath, '.*/')
end
Dirs()
Dirs = nil

local init_fin_orig = GameSetup.init_finalize
function GameSetup:init_finalize(...)
	init_fin_orig(self, ...)
	
	local levelFile = thisDir..'levels/'..(managers.job:current_level_id() or 'a')..'.lua'

	local f,err = io.open(levelFile, 'r')
	if f then
		f:close()
		dofile(levelFile)
	end
end