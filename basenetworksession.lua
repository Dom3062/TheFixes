TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_stats_received_basenetworksession then
	-- basenetworksession.lua"]:1757: attempt to index local 'peer' (a nil value)
	local stats_received_orig = BaseNetworkSession.on_statistics_recieved
	function BaseNetworkSession:on_statistics_recieved(peer_id, ...)
		if self:peer(peer_id) then
            stats_received_orig(self, peer_id, ...)
        end
	end
end
