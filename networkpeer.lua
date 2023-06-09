TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.show_mods_local_peer_networkpeer then
	-- Display mods list for local peer
	local orig_peer_init = NetworkPeer.init
	function NetworkPeer:init(...)
		orig_peer_init(self, ...)

		local local_peer = false
		if self._rpc then
			if self._rpc:ip_at_index(0) == Network:self(SystemInfo:matchmaking_protocol()):ip_at_index(0) then
				local_peer = true
			end
		--[[elseif self._steam_rpc and self._steam_rpc:ip_at_index(0) == Network:self("STEAM"):ip_at_index(0) then
			local_peer = true]]
		end

		if local_peer
			and MenuCallbackHandler.build_mods_list
		then
			self._mods = self._mods or {}
			for k,v in ipairs(MenuCallbackHandler:build_mods_list() or {}) do
				self:register_mod(v[2], v[1])
			end
		end
	end
end


if not TheFixesPreventer.crash_mod_list_encoding_networkpeer then
	-- Crash when opening the mod list of a player
	--  whose mod name(s) in mod.txt(s) contain exotic chars and
	--  are encoded as windows-1251, for example

	-- bad allocation
	-- Script stack:
		-- _text_item_part()  menunodegui.lua:1034        
		-- _create_menu_item() menunodegui.lua:524
		-- _setup_item_rows()  coremenunodegui.lua:147
		-- init()  coremenunodegui.lua:64

	if TheFixesLib and TheFixesLib.utf8_validator then
		local filter = function(s)
			local ok, i = TheFixesLib.utf8_validator(s)
			if ok then return s end
			return "[unknown]"
		end
	
		local orig_register_mod = NetworkPeer.register_mod
		function NetworkPeer:register_mod(id, friendly, ...)

			id = filter(id)
			friendly = filter(friendly)
			
			return orig_register_mod(self, id, friendly, ...)
		end
	end
end
