TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_remove_listenerholder then
	local _remove_orig = ListenerHolder._remove
	function ListenerHolder:_remove(...)
		self._listeners = self._listeners or {}

		return _remove_orig(self, ...)
	end
end