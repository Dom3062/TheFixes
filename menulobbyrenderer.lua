TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_set_slot_join_lobbyrenderer then
	local origfunc = MenuLobbyRenderer.set_slot_joining
	function MenuLobbyRenderer:set_slot_joining(peer, peer_id, ...)
		if self._player_slots[peer_id] then
			origfunc(self, peer, peer_id, ...)
		end
	end
end

if not TheFixesPreventer.crash_set_slot_outfit_lobbyrenderer then
	local origfunc2 = MenuLobbyRenderer.set_slot_outfit
	function MenuLobbyRenderer:set_slot_outfit(slot, ...)
		if self._player_slots and self._player_slots[slot] then
			origfunc2(self, slot, ...)
		end
	end
end

if not TheFixesPreventer.crash_set_player_slot_lobbyrenderer then
	local of3 = MenuLobbyRenderer._set_player_slot
	function MenuLobbyRenderer:_set_player_slot(nr, ...)
		if self._player_slots[nr] then
			of3(self, nr, ...)
		end
	end
end