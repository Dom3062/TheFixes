-- Add a function to force execute a message that has already been added before
function MessageSystem:the_fixes_notify_now_by_added_message(msg)
	for i=1, #(self._messages or {}) do
		if (self._messages[i].message or -1) == msg
			and self._listeners
			and self._listeners[msg]
		then
			for key, value in pairs(self._listeners[msg]) do
				value(unpack(self._messages[i].arg))
			end
			self._messages[i].message = -1
		end
	end
end