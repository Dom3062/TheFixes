local quit_orig = Setup.quit
function Setup:quit(...)
	quit_orig(self, ...)
	
	if jit and jit.os and not jit.os:lower():match('linux') then
		os.execute('taskkill /IM "payday2_win32_release.exe" /F')
	end
end