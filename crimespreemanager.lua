-- Less XP from catch up bonus
--local origfunc = CrimeSpreeManager.calculate_rewards
local function get_rewards(progress)
	local rewards = {}
	local rl = progress
	if rl > 50 then
	
		local function new_reward(name, multiplier)
			local res = rewards[name]
			if tweak_data.crime_spree.rewards[name]	then
				local amnt = tweak_data.crime_spree.rewards[name].amount
				res = res + ((amnt or 0) * math.ceil(multiplier))
			end
			return res
		end
	
		local diff = rl - 50
		rewards['experience'] = 0
		rewards['experience'] = new_reward('experience', 50)
		rewards['cash'] = new_reward('cash', diff * 0.3)
		rewards['continental_coins'] = new_reward('continental_coins', diff * 0.2)
		rewards['loot_drop'] = new_reward('loot_drop', diff * 0.2)
		rewards['random_cosmetic'] = new_reward('random_cosmetic', diff * 0.3)
	end
	return rewards
end

local origfunc2 = CrimeSpreeManager.on_mission_completed
function CrimeSpreeManager:on_mission_completed(...)
	if self:is_active() then
		local old_rewards = self._global.unshown_rewards or {}
		origfunc2(self, ...)
		self._global.unshown_rewards = old_rewards
		local new_rewards = get_rewards(self._spree_add)
		for _, reward in ipairs(tweak_data.crime_spree.rewards) do
			self._global.unshown_rewards[reward.id] = (self._global.unshown_rewards[reward.id] or 0) + new_rewards[reward.id]
		end
	end
end