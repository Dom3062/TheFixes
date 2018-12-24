-- Allow the cops to reload when they are moving
-- https://steamcommunity.com/app/218620/discussions/14/1693785669872895579/?ctp=4#c1698293255119736978
-- Remove recoil animation for dozers
-- https://steamcommunity.com/app/218620/discussions/14/1693785669872895579/?ctp=4#c1698293255119774048
local origfunc = CopActionShoot.update
function CopActionShoot:update(...)
	if self._ext_anim
		and (not TheFixes or TheFixes.cops_reload)
	then
		self._ext_anim.base_no_reload = false
	end
	
	if self._unit:base():has_tag('tank') and self._ext_anim then
		self._ext_anim.base_no_recoil = true
	end
	
	origfunc(self, ...)
end