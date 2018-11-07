local origfunc = SecurityCamera._start_tape_loop
function SecurityCamera:_start_tape_loop(...)
	self:_stop_all_sounds()
	
	origfunc(self, ...)
end