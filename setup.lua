local quit_orig = Setup.quit
function Setup:quit(...)
	quit_orig(self, ...)
	
	os.exit()
end