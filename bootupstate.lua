local origfunc = BootupState.play_next
function BootupState:play_next(...)
	origfunc(self, ...)
	self._play_data = self._play_data or {}
end