TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.tank_remove_recoil_anim then
	-- Remove recoil animation for dozers
	-- https://steamcommunity.com/app/218620/discussions/14/1693785669872895579/?ctp=4#c1698293255119774048
	local origfunc = CopActionShoot.update
	function CopActionShoot:update(...)
		if self._unit:base():has_tag('tank') and self._ext_anim then
			self._ext_anim.base_no_recoil = true
		end
		origfunc(self, ...)
	end
end