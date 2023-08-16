function NetworkMatchMakingSTEAM:join_server_with_check(room_id, is_invite) --- <--- +is_invite
	managers.menu:show_joining_lobby_dialog()

	local lobby = Steam:lobby(room_id)

	-- Lines 811-811
	local function empty()
	end

	-- Lines 812-865
	local function f()
		print("NetworkMatchMakingSTEAM:join_server_with_check f")
		lobby:setup_callback(empty)

		local attributes = self:_lobby_to_numbers(lobby)

		if NetworkMatchMakingSTEAM._BUILD_SEARCH_INTEREST_KEY then
			local ikey = lobby:key_value(NetworkMatchMakingSTEAM._BUILD_SEARCH_INTEREST_KEY)

			if ikey == "value_missing" or ikey == "value_pending" then
				print("Wrong version!!")
				managers.system_menu:close("join_server")
				managers.menu:show_failed_joining_dialog()

				return
			end
		end

		local event_key = lobby:key_value("event")
		local wanted_event_key = Global.game_settings.search_event_lobbies_override and 1 or 0

		if event_key == "value_missing" or event_key == "value_pending" or tonumber(event_key) ~= wanted_event_key then
			print("Wrong event game mode!", "wanted", wanted_event_key, "event key", event_key)
			managers.system_menu:close("join_server")
			managers.menu:show_failed_joining_dialog()

			return
		end

		local server_ok, ok_error = self:is_server_ok(nil, self:_make_room_info(lobby), {
			numbers = attributes
		}, is_invite)

		if server_ok then
			self:join_server(room_id, true, false, is_invite) --- <--- copying calling the function as in NetworkMatchMakingEPIC:join_server()
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

	lobby:setup_callback(f)

	if lobby:key_value("state") == "value_pending" then
		print("NetworkMatchMakingSTEAM:join_server_with_check value_pending")
		lobby:request_data()
	else
		f()
	end
end

function NetworkMatchMakingSTEAM:join_server(room_id, skip_showing_dialog, quickplay, is_invite) --- <--- +is_invite
	if not skip_showing_dialog then
		managers.menu:show_joining_lobby_dialog()
	end

	-- Lines 950-1135
	local function f(result, handler)
		print("[NetworkMatchMakingSTEAM:join_server:f]", result, handler)
		managers.system_menu:close("join_server")

		if result == "success" then
			print("Success!")

			self.lobby_handler = handler
			local _, host_id, owner = self.lobby_handler:get_server_details()

			print("[NetworkMatchMakingSTEAM:join_server] server details", _, host_id)
			print("Gonna handshake now!")

			self._server_rpc = Network:handshake(host_id:tostring(), nil, "STEAM")

			print("Handshook!")
			print("Server RPC:", self._server_rpc and self._server_rpc:ip_at_index(0))

			if not self._server_rpc then
				return
			end

			self.lobby_handler:setup_callbacks(NetworkMatchMakingSTEAM._on_memberstatus_change, NetworkMatchMakingSTEAM._on_data_update, NetworkMatchMakingSTEAM._on_chat_message)
			managers.network:start_client()
			managers.menu:show_waiting_for_server_response({
				cancel_func = function ()
					managers.network:session():on_join_request_cancelled()
				end
			})

			local lobby_data = self.lobby_handler:get_lobby_data()

			if lobby_data then
				local spree_level = tonumber(lobby_data.crime_spree)

				if spree_level and spree_level >= 0 then
					managers.crime_spree:enable_crime_spree_gamemode()

					if lobby_data.crime_spree_mission then
						managers.crime_spree:set_temporary_mission(lobby_data.crime_spree_mission)
					end
				end
			end

			managers.skirmish:on_joined_server(lobby_data, self.lobby_handler:get_lobby_data())

			-- Lines 993-1125
			local function joined_game(res, level_index, difficulty_index, state_index)
				if res ~= "JOINED_LOBBY" and res ~= "JOINED_GAME" then
					managers.crime_spree:disable_crime_spree_gamemode()
				end

				managers.system_menu:close("waiting_for_server_response")
				print("[NetworkMatchMakingSTEAM:join_server:joined_game]", res, level_index, difficulty_index, state_index)

				if res == "JOINED_LOBBY" then
					MenuCallbackHandler:crimenet_focus_changed(nil, false)
					managers.menu:on_enter_lobby()
				elseif res == "JOINED_GAME" then
					local level_id = tweak_data.levels:get_level_name_from_index(level_index)
					Global.game_settings.level_id = level_id

					managers.network:session():local_peer():set_in_lobby(false)
				elseif res == "KICKED" then
					managers.network.matchmake:leave_game()
					managers.network.voice_chat:destroy_voice()
					managers.network:queue_stop_network()
					managers.menu:show_peer_kicked_dialog()
				elseif res == "TIMED_OUT" then
					managers.network.matchmake:leave_game()
					managers.network.voice_chat:destroy_voice()
					managers.network:queue_stop_network()
					managers.menu:show_request_timed_out_dialog()
				elseif res == "GAME_STARTED" then
					managers.network.matchmake:leave_game()
					managers.network.voice_chat:destroy_voice()
					managers.network:queue_stop_network()
					managers.menu:show_game_started_dialog()
				elseif res == "DO_NOT_OWN_HEIST" then
					managers.network.matchmake:leave_game()
					managers.network.voice_chat:destroy_voice()
					managers.network:queue_stop_network()
					managers.menu:show_does_not_own_heist()
				elseif res == "CANCELLED" then
					managers.network.matchmake:leave_game()
					managers.network.voice_chat:destroy_voice()
					managers.network:queue_stop_network()
				elseif res == "FAILED_CONNECT" then
					managers.network.matchmake:leave_game()
					managers.network.voice_chat:destroy_voice()
					managers.network:queue_stop_network()
					managers.menu:show_failed_joining_dialog()
				elseif res == "GAME_FULL" then
					managers.network.matchmake:leave_game()
					managers.network.voice_chat:destroy_voice()
					managers.network:queue_stop_network()
					managers.menu:show_game_is_full()
				elseif res == "LOW_LEVEL" then
					managers.network.matchmake:leave_game()
					managers.network.voice_chat:destroy_voice()
					managers.network:queue_stop_network()
					managers.menu:show_too_low_level()
				elseif res == "WRONG_VERSION" then
					managers.network.matchmake:leave_game()
					managers.network.voice_chat:destroy_voice()
					managers.network:queue_stop_network()
					managers.menu:show_wrong_version_message()
				elseif res == "AUTH_FAILED" or res == "AUTH_HOST_FAILED" then
					managers.network.matchmake:leave_game()
					managers.network.voice_chat:destroy_voice()
					managers.network:queue_stop_network()

					Global.on_remove_peer_message = res == "AUTH_HOST_FAILED" and "dialog_authentication_host_fail" or "dialog_authentication_fail"

					managers.menu:show_peer_kicked_dialog()
				elseif res == "BANNED" then
					managers.network.matchmake:leave_game()
					managers.network.voice_chat:destroy_voice()
					managers.network:queue_stop_network()
					managers.menu:show_peer_banned_dialog()
				elseif res == "MODS_DISALLOWED" then
					managers.network.matchmake:leave_game()
					managers.network.voice_chat:destroy_voice()
					managers.network:queue_stop_network()
					managers.menu:show_mods_disallowed_dialog()
				elseif res == "SHUB_BLOCKED" then
					managers.network.matchmake:leave_game()
					managers.network.voice_chat:destroy_voice()
					managers.network:queue_stop_network()
					managers.menu:show_shub_blocked_dialog()
				elseif res == "SHUB_NOT_FRIEND" then
					managers.network.matchmake:leave_game()
					managers.network.voice_chat:destroy_voice()
					managers.network:queue_stop_network()
					managers.menu:show_shub_not_friend_dialog()
				elseif res == "HOST_LOADING" then
					managers.network.matchmake:leave_game()
					managers.network.voice_chat:destroy_voice()
					managers.network:queue_stop_network()
					managers.menu:show_host_loading_dialog()
				elseif res == "ALREADY_JOINED" then
					managers.network.matchmake:leave_game()
					managers.network.voice_chat:destroy_voice()
					managers.network:queue_stop_network()
					managers.menu:show_already_joined_dialog()
				else
					Application:error("[NetworkMatchMakingSTEAM:join_server] FAILED TO START MULTIPLAYER!", res)
				end
			end

			managers.network:join_game_at_host_rpc(self._server_rpc, is_invite, joined_game) --- <--- Added is_invite as second parameter because "join_game_at_host_rpc" needs as second, otherwise nothing gets synced to other players

			if quickplay then
				Telemetry:last_quickplay_room_id(self.lobby_handler:id())
			end
		else
			managers.menu:show_failed_joining_dialog()
			self:search_lobby(self:search_friends_only())
		end
	end

	Steam:join_lobby(room_id, f)
end