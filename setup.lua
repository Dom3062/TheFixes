local quit_orig = Setup.quit
function Setup:quit(...)
    quit_orig(self, ...)
    if (not TheFixes or TheFixes.instant_quit) then
        local current_os = BLT:GetOS()
        if current_os == "windows" then
            os.execute('taskkill /IM "payday2_win32_release.exe" /F')
        elseif current_os == "linux" then
            os.execute('pkill --signal 9 payday2_release')
        end
    end
end