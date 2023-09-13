-- Fixes Steam players not appearing on "Played with" tab
-- Only happens on Steam with EOS Matchmaking
if SystemInfo:distribution() == Idstring("STEAM") and SystemInfo:matchmaking() == Idstring("MM_EPIC") then
	local add_peer = BaseNetworkSession.add_peer
	function BaseNetworkSession:add_peer(...)
		local id, peer = add_peer(self, ...)
		if peer and peer:account_type_str() == "STEAM" and Steam then -- Check "Steam" just in case, but it should exists
			Steam:set_played_with(peer:account_id())
		end
		return id, peer
	end
end