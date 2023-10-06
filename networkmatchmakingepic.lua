local TheFixes = TheFixes or {}
if TheFixes:CheckHook("NetworkMatchMakingEPIC") then
	return
end

local search_lobby_original = NetworkMatchMakingEPIC.search_lobby
function NetworkMatchMakingEPIC:search_lobby(...)
	if LobbyBrowser then
		LobbyBrowser:clear_lobby_filters()
	end
    search_lobby_original(self, ...)
end

function NetworkMatchMakingEPIC:join_server_with_check(room_id, is_invite)
	managers.menu:show_joining_lobby_dialog()
	managers.socialhub:remove_pending_lobby(room_id)

	local function lobby_found_cb(lobby)
		if not lobby then
			managers.system_menu:close("join_server")
			managers.menu:show_failed_joining_dialog()
			return
		end

		local attributes = self:_lobby_to_numbers(lobby)

		if NetworkMatchMakingEPIC._BUILD_SEARCH_INTEREST_KEY then
			local ikey = lobby:key_value(NetworkMatchMakingEPIC._BUILD_SEARCH_INTEREST_KEY)
			-- ikey is an empty string if the key is not found on an epic lobby
			if ikey == "value_missing" or ikey == "value_pending" or ikey == "" then
				managers.system_menu:close("join_server")
				managers.menu:show_failed_joining_dialog()
				return
			end
		end

		local server_ok, ok_error = self:is_server_ok(nil, self:_make_room_info(lobby), { numbers = attributes }, is_invite)

		if server_ok then
			self:join_server(room_id, true, false, is_invite)
		else
			managers.system_menu:close("join_server")

			if ok_error == 1 then
				managers.menu:show_game_started_dialog()
			elseif ok_error == 2 then
				managers.menu:show_game_permission_changed_dialog()
			elseif ok_error == 3 then
				managers.menu:show_too_low_level()
			elseif ok_error == 4 then
				managers.menu:show_does_not_own_heist()
			elseif ok_error == 5 then
				managers.menu:show_heist_is_locked_dialog()
			elseif ok_error == 6 then
				managers.menu:show_crime_spree_locked_dialog()
			end

			self:search_lobby(self:search_friends_only())
		end
	end

	EpicMM:lobby(room_id, lobby_found_cb)
end