TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.loop_sound_securitycamera then
	local origfunc = SecurityCamera._start_tape_loop
	function SecurityCamera:_start_tape_loop(...)
		self:_stop_all_sounds()
		
		origfunc(self, ...)
	end
end