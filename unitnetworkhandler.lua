-- Add a function to sync 'Say Hello to My Big Friend' achievement
function UnitNetworkHandler:sync_friend_4(unit, attack_data)
	if not unit
		or type(unit) ~= 'table'
		or not attack_data
		or type(attack_data) ~= 'table'
	then
		return
	end
	
	local cd = unit:character_damage()
	if cd and cd._check_friend_4 then
		cd._check_friend_4(attack_data)
	end
end