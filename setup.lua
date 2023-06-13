local quit_orig = Setup.quit
function Setup:quit(...)
	quit_orig(self, ...)
	
	if jit and jit.os and not jit.os:lower():match('linux')
		and (not TheFixes or TheFixes.instant_quit)
	then
		os.execute('taskkill /IM "payday2_win32_release.exe" /F')
	end

	if (BLT:GetOS() == "linux") and (not TheFixes or TheFixes.instant_quit)
	then
		os.execute('pkill --signal 9 payday2_release')
	end
end
