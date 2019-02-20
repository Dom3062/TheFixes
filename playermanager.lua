TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.alesso_cutters_playerman then
	-- Always pick up those cutters
	local origfunc = PlayerManager._can_pickup_special_equipment
	function PlayerManager:_can_pickup_special_equipment(special_equipment, name, ...)
		if special_equipment.amount and name == 'circle_cutter' then
			return true
		end
		return origfunc(self, special_equipment, name, ...)
	end
end

if not TheFixesPreventer.sixth_ammo_box_playerman then
	-- Execute second ammo box once the enemy is killed
	--  (not after the bullet finished hitting enemies)
	local origfunc2 = PlayerManager.on_killshot
	function PlayerManager:on_killshot(...)
		origfunc2(self, ...)
		
		if self._message_system
			and self._message_system.the_fixes_notify_now_by_added_message
		then
			self._message_system:the_fixes_notify_now_by_added_message(Message.OnEnemyKilled)
		end
	end
end

if not TheFixesPreventer.remove_bag_from_back_playerman then
	-- If someone throws a bag then remove it from his back and from hud
	local origfunc3 = PlayerManager.sync_carry_data
	function PlayerManager:sync_carry_data(unit, carry_id, carry_multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, position, dir, throw_distance_multiplier_upgrade_level, zipline_unit, peer_id, ...)
		origfunc3(self, unit, carry_id, carry_multiplier, dye_initiated, has_dye_pack, dye_value_multiplier, position, dir, throw_distance_multiplier_upgrade_level, zipline_unit, peer_id, ...)
		
		self._global.synced_carry[peer_id] = nil
		
		if managers.network:session():local_peer():id() == peer_id then
			return
		end
		
		local pl_unit = managers.network:session():peer(peer_id)
		local hud_pnl = pl_unit and managers.hud:get_teammate_panel_by_peer(pl_unit) or nil
		
		if pl_unit then
			managers.hud:remove_name_label_carry_info(pl_unit:id() or 0)
		end
		
		pl_unit = pl_unit and pl_unit:unit() or nil
		if pl_unit then
			pl_unit:movement():_destroy_current_carry_unit()
			
			if hud_pnl then
				hud_pnl:remove_carry_info()
			end
		end
	end
end