TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.show_mods_local_peer_networkpeer then
	-- Display mods list for local peer
	local orig_peer_init = NetworkPeer.init
	function NetworkPeer:init(...)
		orig_peer_init(self, ...)
		
		local local_peer = false
		if self._rpc then
			if self._rpc:ip_at_index(0) == Network:self("TCP_IP"):ip_at_index(0) then
				local_peer = true
			end
		elseif self._steam_rpc and self._steam_rpc:ip_at_index(0) == Network:self("STEAM"):ip_at_index(0) then
			local_peer = true
		end
		
		if local_peer
			and MenuCallbackHandler.build_mods_list
		then
			self._mods = self._mods or {}
			for k,v in ipairs(MenuCallbackHandler:build_mods_list() or {}) do
				table.insert(self._mods, {
					id = v[2] or '',
					name = v[1] or ''
				})
			end
		end
	end
end