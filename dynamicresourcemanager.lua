TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.crash_unload_weapon_dynamicresource then
	local origfunc = DynamicResourceManager.unload
	function DynamicResourceManager:unload(resource_type, resource_name, package_name, keep_using, ...)
		local key = self._get_resource_key(resource_type, resource_name, package_name)
		local entry = self._dyn_resources[key]
		
		if entry then
			origfunc(self, resource_type, resource_name, package_name, keep_using, ...)
		end
	end
end