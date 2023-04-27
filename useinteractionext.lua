TheFixesPreventer = TheFixesPreventer or {}
if TheFixesPreventer.fix_client_unable_to_interact then
	return
end

local interact = UseInteractionExt.interact
function UseInteractionExt:interact(...)
    local interacted = interact(self, ...)
    if interacted and self._unit:id() == -1 then
        managers.network:session():send_to_peers_synched("sync_interacted", self._unit, -2, self.tweak_data, 1)
    end
    -- TODO
	-- Apparently units are created with ID of -1 for some reason, preventing syncing
	-- Check why it is happening, most likely they are missing a class
	-- Examples:
	-- Counterfeit: Can't insert paper into printer
	-- Border Crossing: Can't detach fuel hose in the plane
	-- Original mod: https://modworkshop.net/mod/40368
	-- This is an optimized version, fixing interactions better; by Hoppip
    return interacted
end