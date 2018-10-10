local origfunc = UpgradesManager.load
function UpgradesManager:load(data, ...)
	data.UpgradesManager = data.UpgradesManager or {automanage=false, progress = {0,0,0,0}, target_tree=0, disabled_visual_upgrades={}}
	return origfunc(self, data, ...)
end