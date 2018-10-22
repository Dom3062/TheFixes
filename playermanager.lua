-- Always pick up those cutters
local origfunc = PlayerManager._can_pickup_special_equipment
function PlayerManager:_can_pickup_special_equipment(special_equipment, name, ...)
	if special_equipment.amount and name == 'circle_cutter' then
		return true
	end
	return origfunc(self, special_equipment, name, ...)
end

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