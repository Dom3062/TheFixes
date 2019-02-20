TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_load_upgradesman then
	local origfunc = UpgradesManager.load
	function UpgradesManager:load(data, ...)
		data.UpgradesManager = data.UpgradesManager or {automanage=false, progress = {0,0,0,0}, target_tree=0, disabled_visual_upgrades={}}
		return origfunc(self, data, ...)
	end
end

-- Avoid acquiring certain upgrades when the player has better ones
local origfunc2 = UpgradesManager.aquire
function UpgradesManager:aquire(id, ...)
	local next_acquired = false
	local td = tweak_data.upgrades.definitions[id]
	if td and td.the_fixes_next
		and self:aquired(td.the_fixes_next)
	then
		self:unaquire(td.the_fixes_next, td.the_fixes_next_identifier)
		next_acquired = true
	end

	origfunc2(self, id, ...)
	
	if next_acquired then
		self:aquire(td.the_fixes_next, false, td.the_fixes_next_identifier)
	end
end