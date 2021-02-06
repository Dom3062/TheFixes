-- Functions for working with mission scripts

local ret = {}

-- The last id provided by GetId() called with :
ret.lastId = 999999

-- Get an id that is not in use by any other element
ret.GetId = function(self) 
    self = self or { lastId = 999999 }
	self.lastId = self.lastId + 1
	while managers.mission:get_element_by_id(self.lastId) do
		self.lastId = self.lastId + 1
	end
	return self.lastId
end

-- Get the element that matches both id and name
ret.getElementByIdAndName = function(self, id, name)
    if not name then
        name = id
        id = self
    end
    for sname, script in pairs(managers.mission._scripts) do
        local elem = script:element(id)
        if elem and elem._editor_name == name then
            return elem
        end
    end
end

return ret
