-- Make shotgun pellets prioritize turret's vulnerable spots
local origfunc2 = SentryGunDamage and SentryGunDamage.is_head or nil
function SentryGunDamage:is_head(body, ...)
	local head = origfunc2 and origfunc2(self, body, ...) or nil
	
	if not head and body
		and (not TheFixes or TheFixes.shotgun_turret)
	then
		if self._invulnerable_bodies
			and not self._invulnerable_bodies[body:name():key()]
		then
			head = true
		end
	end
	
	return head
end