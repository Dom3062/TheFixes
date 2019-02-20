TheFixesPreventer = TheFixesPreventer or {}
if TheFixesPreventer.heist_mallcrasher_secure_zone then
	return
end

if Network:is_client() then
	return
end

local prj_inst_orig = ElementAreaTrigger.project_instigators
function ElementAreaTrigger:project_instigators(...)
	if self._id ~= 300327 then
		return prj_inst_orig(self, ...)
	end

	local res = prj_inst_orig(self, ...)
	
	if self._values.instigator ~= "loot" then
		local old_inst = self._values.instigator
		self._values.instigator = "loot"
		local res2 = prj_inst_orig(self, ...)
		self._values.instigator = old_inst
		
		for k,v in ipairs(res2) do
			if alive(v) then
				local pos = Vector3() 
				v:m_position(pos)
				
				if self:_is_inside(pos) then
					local carry_ext = v:carry_data()

					if carry_ext then
						if carry_ext:value() > 0 then
							carry_ext:disarm()
							
							if Network:is_server() then
								local carry_id = carry_ext:carry_id()
								local multiplier = carry_ext:multiplier()
								local peer_id = carry_ext:latest_peer_id()

								managers.loot:secure(carry_id, multiplier, false, peer_id)
							end

							carry_ext:set_value(0)

							if v:damage():has_sequence("secured") then
								v:damage():run_sequence_simple("secured")
							end
							
							v:set_slot(0)
						end
					end
				end
			end
		end
	end
	
	return res
end

