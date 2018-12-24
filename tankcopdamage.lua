-- Make shotgun pellets prioritize dozer's faceplate and visor
local origfunc2 = TankCopDamage and TankCopDamage.is_head or nil
function TankCopDamage:is_head(body, ...)
	local head = origfunc2 and origfunc2(self, body, ...) or TankCopDamage.super.is_head(self, body, ...)
	
	if not head and body 
		and (not TheFixes or TheFixes.shotgun_dozer_face)
	then
		local bn = body:name():key()
		if bn == 'f46eb16d189339da'
			or bn == 'f260d73afd0c74fe'
		then
			head = true
		end
	end
	
	return head
end