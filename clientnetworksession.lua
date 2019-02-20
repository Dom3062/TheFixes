TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_join_req_reply_clientsession then
	local join_req_reply_orig = ClientNetworkSession.on_join_request_reply
	function ClientNetworkSession:on_join_request_reply(reply, my_peer_id, my_character, level_index, difficulty_index, one_down, state_index, server_character, user_id, mission, job_id_index, job_stage, alternative_job_stage, interupt_job_stage_level_index, xuid, auth_ticket, sender, ...)
		if sender then
			join_req_reply_orig(self, reply, my_peer_id, my_character, level_index, difficulty_index, one_down, state_index, server_character, user_id, mission, job_id_index, job_stage, alternative_job_stage, interupt_job_stage_level_index, xuid, auth_ticket, sender, ...)
		end
	end
end