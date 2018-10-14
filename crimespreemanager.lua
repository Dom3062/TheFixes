-- Less XP from catch up bonus
local function get_rewards(progress, old_rewards)
	local rewards = old_rewards or {}
	local rl = progress or 0
	if rl > 50 then
	
		local function new_reward(name, multiplier)
			local res = rewards[name] or 0
			if tweak_data.crime_spree.rewards[name]	then
				local amnt = tweak_data.crime_spree.rewards[name].amount
				res = res + ((amnt or 0) * math.ceil(multiplier))
			end
			return res
		end
	
		local diff = rl - 50
		rewards['experience'] = 0
		rewards['experience'] = 1000000--new_reward('experience', 50)
		rewards['cash'] = new_reward('cash', diff * 0.3)
		rewards['continental_coins'] = new_reward('continental_coins', diff * 0.2)
		rewards['loot_drop'] = new_reward('loot_drop', diff * 0.2)
		rewards['random_cosmetic'] = new_reward('random_cosmetic', diff * 0.3)
	end
	return rewards
end
local origfunc3 = CrimeSpreeManager.calculate_rewards
function CrimeSpreeManager:calculate_rewards(...)
	local rewards = origfunc3(self, ...) or {}
	rewards = get_rewards(self:reward_level(), rewards)
	return rewards
end