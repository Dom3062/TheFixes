TheFixesPreventer = TheFixesPreventer or {}
if TheFixesPreventer.heist_goats2_multiple_assets then
	return
end

-- This is supposed to fix the issue where assets spawn multiple times
local on_exec_orig = ElementSpawnDeployable.on_executed
local spawned = {}
function ElementSpawnDeployable:on_executed(...)
	if not self._values.enabled then
		return
	end
	
	if self._values.deployable_id and self._values.deployable_id ~= 'none' then
		if spawned[self._values.deployable_id]
			and spawned[self._values.deployable_id] == self._values.position
		then
			return
		end
	end
	spawned[self._values.deployable_id] = self._values.position
	on_exec_orig(self, ...)
end