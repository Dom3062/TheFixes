-- Fix for Gambler's ammo sharing: fix for weapons with low pickup
local origfunc = AmmoClip.sync_net_event
function AmmoClip:sync_net_event(event, peer, ...)
	if event == AmmoClip.EVENT_IDS.bonnie_share_ammo
		and (not TheFixes or TheFixes.gambler)
	then
		local player = managers.player:local_player()

		if not alive(player) or not player:character_damage() or player:character_damage():is_downed() or player:character_damage():dead() then
			return
		end
		
		local inventory = player:inventory()

		if inventory then
			local picked_up, add_amount = false, nil

			for id, weapon in pairs(inventory:available_selections()) do
				picked_up, add_amount = weapon.unit:base():add_ammo(tweak_data.upgrades.loose_ammo_give_team_ratio or 0.25) or picked_up
	--------------------------------------------------
				if picked_up and (not add_amount or add_amount < 1) then
					local wub = weapon.unit:base()
					if wub and wub._ammo_pickup and wub._ammo_pickup[2] < 2 then
						local prob = ((wub._ammo_pickup[1] + wub._ammo_pickup[2])/2) * tweak_data.upgrades.loose_ammo_give_team_ratio
						if prob > math.random() then
							picked_up, add_amount = wub:add_ammo(nil, 1) or picked_up
						end
					end
				end
	--------------------------------------------------
			end

			if picked_up then
				player:sound():play(self._pickup_event or "pickup_ammo", nil, true)

				for id, weapon in pairs(inventory:available_selections()) do
					managers.hud:set_ammo_amount(id, weapon.unit:base():ammo_info())
				end
			end
		end
		return
	end
	return origfunc(self, event, peer, ...)
end