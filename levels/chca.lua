TheFixesPreventer = TheFixesPreventer or {}
if TheFixesPreventer.heist_chca then
	return
end

--https://steamcommunity.com/app/218620/discussions/14/3418809548713828181/

local group = managers.portal:unit_group("Cabins_Right")
if not group then
    return
end

local group_shapes = group:shapes()
if not group_shapes then
    return
end

local BrokenShapeVector = tostring(Vector3(-6600, 10800, -100))
for _, shape in pairs(group_shapes) do
    if BrokenShapeVector == tostring(shape:position()) then
        shape:set_position(Vector3(-6600, 11000, -100))
        shape:set_property_string("depth", 6575)
        if shape.fs_reset_bounds then -- In case the player has "Full Speed Swarm" mod installed, update cached values
            shape:fs_reset_bounds()
        end
    end
end