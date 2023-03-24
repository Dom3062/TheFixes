-- By Hoppip (with permission)
local TF = TheFixes
TheFixesPreventer = TheFixesPreventer or {}
if TF._cache.fix_unnecessary_bandwidth_movement_sync or TheFixesPreventer.fix_unnecessary_bandwidth_movement_sync then
	return
end
if BLT and BLT.Mods and not TF._cache.fix_unnecessary_bandwidth_movement_sync_checked then
	local mods = BLT.Mods:Mods()
	for _, v in ipairs(mods) do
		if v.name and v.name:lower() == 'bandwidth saver' then
			log('[The Fixes] fix_unnecessary_bandwidth_movement_sync disabled')
			TF._cache.fix_unnecessary_bandwidth_movement_sync = true
			return
		end
	end
	TF._cache.fix_unnecessary_bandwidth_movement_sync_checked = true
end

--https://steamcommunity.com/app/218620/discussions/14/3782498683139018706/

local delta_time_limit = 1 / 10
local delta_angle_limit = 5
local delta_dis_sq_limit = 10 ^ 2

if RequiredScript == "lib/units/beings/player/states/playerstandard" then
	local _update_network_position_original = PlayerStandard._update_network_position
	function PlayerStandard:_update_network_position(t, dt, cur_pos, ...)
		if self._last_sent_pos_t and self._last_sent_pos_t + delta_time_limit > t then
			return -- Don't send network message if last send time was too recent
		end

		if mvector3.distance_sq(self._last_sent_pos, cur_pos) < delta_dis_sq_limit then
			return -- Don't send network message if distance difference is too low
		end

		return _update_network_position_original(self, t, dt, cur_pos, ...)
	end

elseif RequiredScript == "lib/units/beings/player/playercamera" then
	-- Need to override this function to change the condition for sending data
	local mvec1 = Vector3()
	Hooks:OverrideFunction(PlayerCamera, "set_rotation", function (self, rot)
		if _G.IS_VR then
			self._camera_object:set_rotation(rot)
		end

		mrotation.y(rot, mvec1)
		mvector3.multiply(mvec1, 100000)
		mvector3.add(mvec1, self._m_cam_pos)

		if not _G.IS_VR then
			self._camera_controller:set_target(mvec1)
		end

		mrotation.z(rot, mvec1)

		if not _G.IS_VR then
			self._camera_controller:set_default_up(mvec1)
		end

		mrotation.set_yaw_pitch_roll(self._m_cam_rot, rot:yaw(), rot:pitch(), rot:roll())
		mrotation.y(self._m_cam_rot, self._m_cam_fwd)
		mrotation.x(self._m_cam_rot, self._m_cam_right)

		local t = TimerManager:game():time()
		if self._last_sync_t + delta_time_limit > t then
			return -- Don't send network message if last send time was too recent
		end

		local sync_yaw = rot:yaw() % 360
		if sync_yaw < 0 then
			sync_yaw = 360 - sync_yaw
		end
		sync_yaw = math.floor(255 * sync_yaw / 360)

		local sync_pitch = _G.IS_VR and math.clamp(rot:pitch(), -30, 60) + 85 or math.clamp(rot:pitch(), -85, 85) + 85
		sync_pitch = math.floor(127 * sync_pitch / 170)

		local angle_delta = math.abs(self._sync_dir.yaw - sync_yaw) + math.abs(self._sync_dir.pitch - sync_pitch)
		if angle_delta < delta_angle_limit then
			return -- Don't send network message if angle difference is too low
		end

		if _G.IS_VR then
			local locked_look_dir = self._locked_look_dir_t and t < self._locked_look_dir_t
			if locked_look_dir then
				if self._unit:hand():arm_simulation_enabled() then
					self._unit:hand():send_filtered("set_look_dir", sync_yaw, sync_pitch)
					self._unit:hand():send_inv_filtered("set_look_dir", self._locked_yaw, self._locked_pitch)
				else
					self._unit:network():send("set_look_dir", self._locked_yaw, self._locked_pitch)
				end
			else
				self._unit:network():send("set_look_dir", sync_yaw, sync_pitch)
			end
		else
			self._unit:network():send("set_look_dir", sync_yaw, sync_pitch)
		end

		self._sync_dir.yaw = sync_yaw
		self._sync_dir.pitch = sync_pitch
		self._last_sync_t = t
	end)
end