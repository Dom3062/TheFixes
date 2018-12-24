-- Fix for Gambler's ammo sharing: always at least 1 bullet
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
			local picked_up = false

			for id, weapon in pairs(inventory:available_selections()) do
				picked_up, add_amount = weapon.unit:base():add_ammo(tweak_data.upgrades.loose_ammo_give_team_ratio or 0.25) or picked_up
	--------------------------------------------------
				if picked_up and (not add_amount or add_amount < 1) then
					picked_up, add_amount = weapon.unit:base():add_ammo(nil, 1) or picked_up
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