TheFixesPreventer = TheFixesPreventer or {}

if not TheFixesPreventer.crash_ban_list_encoding_banlistman then
	-- https://steamcommunity.com/app/218620/discussions/14/2632850678908112572/
        
    if TheFixesLib and TheFixesLib.utf8_validator then
        local origfunc = BanListManager.load
        function BanListManager:load(data, ...)
            if data.ban_list and data.ban_list.banned then
                local filtered = {}
                for k,v in pairs(data.ban_list.banned) do
                    filtered[k] = v
                    if not (v.name and TheFixesLib.utf8_validator(v.name)) then
                        filtered[k].name = "[unknown]"
                    end
                end
                data.ban_list.banned = filtered
            end
            
            origfunc(self, data, ...)
        end
    end
end
