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

if not TheFixesPreventer.crash_set_equipment_playerman then
	local set_equipment_orig = PlayerManager.set_synced_equipment_possession
	function PlayerManager:set_synced_equipment_possession(peer_id, equipment, ...)
		if equipment and tweak_data.equipments.specials[equipment] then
			set_equipment_orig(self, peer_id, equipment, ...)
		end
	end
end

if not TheFixesPreventer.crash_upgrade_by_level_playerman then
	local upgrade_by_level_orig = PlayerManager.upgrade_value_by_level
	function PlayerManager:upgrade_value_by_level(category, upgrade, ...)
		tweak_data.upgrades.values[category] = tweak_data.upgrades.values[category] or {}
		tweak_data.upgrades.values[category][upgrade] = tweak_data.upgrades.values[category][upgrade] or {}
		return upgrade_by_level_orig(self, category, upgrade, ...)
	end
end
