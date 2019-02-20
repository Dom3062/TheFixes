TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.sentry_ammo_round then
	-- Fix ammo rounding on sentry gun pick up
	local origfunc = SentryGunBase.on_picked_up
	function SentryGunBase.on_picked_up(sentry_type, ammo_ratio, sentry_uid, ...)
		
		local player_unit = managers.player:player_unit()
		if not player_unit then
			return
		end
		
		local deployement_cost = player_unit:equipment() and player_unit:equipment():get_sentry_deployement_cost(sentry_uid)
		
		local current = {}
		
		local inventory = player_unit:inventory()
		if inventory and deployement_cost then
			for index, weapon in pairs(inventory:available_selections()) do
				current[index] = weapon.unit:base():get_ammo_total()
			end
		end
		
		origfunc(sentry_type, ammo_ratio, sentry_uid, ...)
		
		local same = true
		if inventory and deployement_cost then
			for index, weapon in pairs(inventory:available_selections()) do
				if current[index] + math.ceil((deployement_cost[index] or 0) * ammo_ratio) ~= weapon.unit:base():get_ammo_total() then
					same = false
				end
			end
			
			if same then
				for index, weapon in pairs(inventory:available_selections()) do
					weapon.unit:base():set_ammo_total(current[index])
					
					local refund = math.floor((deployement_cost[index] * ammo_ratio) + 0.5)
					weapon.unit:base():add_ammo_in_bullets(refund)
					managers.hud:set_ammo_amount(index, weapon.unit:base():ammo_info())
				end
			end
		end
		
	end
end