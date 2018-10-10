local origfunc = MoneyManager.load
function MoneyManager:load(data, ...)
	data.MoneyManager = data.MoneyManager or {total=1000000, total_collected = 0, offshore=10000000, total_spent=0}
	return origfunc(self, data, ...)
end