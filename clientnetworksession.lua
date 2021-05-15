TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_join_req_reply_clientsession then
	local join_req_reply_orig = ClientNetworkSession.on_join_request_reply
	function ClientNetworkSession:on_join_request_reply(...)
		local lastInx = select("#", ...)
		if lastInx > 0 then
			if select(lastInx, ...) then
				return join_req_reply_orig(self, ...)
			end
		else
			return join_req_reply_orig(self, ...)
		end
	end
end