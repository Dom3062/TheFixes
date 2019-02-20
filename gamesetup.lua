TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.heist_fixes_everything then
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
		
		local id = (managers.job:current_level_id() or 'all')
		id = id:gsub('_night$', '')
		local levelFile = thisDir..'levels/'..id..'.lua'

		local f,err = io.open(levelFile, 'r')
		if f then
			f:close()
			dofile(levelFile)
		end
	end
end