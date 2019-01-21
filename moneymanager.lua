local origfunc = MoneyManager.load
function MoneyManager:load(data, ...)
	data.MoneyManager = data.MoneyManager or {total=1000000, total_collected = 0, offshore=10000000, total_spent=0}
	return origfunc(self, data, ...)
end

local get_craft_price_orig = MoneyManager.get_mask_crafting_price
function MoneyManager:get_mask_crafting_price(mask_id, global_value, ...)
	return get_craft_price_orig(self, mask_id, global_value or "normal", ...)
end