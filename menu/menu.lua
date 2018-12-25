TheFixes = TheFixes or {}

TheFixes = {
	fire_dot = true,
	shotgun_dozer_face = true,
	gambler = true,
	shotgun_push = true,
	dozers_counting = true,
	shotgun_turret = true,
	dozers_walk = true,
	cops_reload = true,
	instant_quit = true,
	last_msg_id = ''
}

local thisPath
local thisDir
local upDir
local function Dirs()
	thisPath = debug.getinfo(2, "S").source:sub(2)
	thisDir = string.match(thisPath, '.*/')
	upDir = thisDir:match('(.*/).-/')
end
Dirs()
Dirs = nil

-- If there is no BLT
if not MenuHelper then
	return
end

local function LoadSettings()
	local file = io.open(SavePath .. 'The Fixes.txt', "r")
	if file then
		for k, v in pairs(json.decode(file:read("*all")) or {}) do
			TheFixes[k] = v
		end
		file:close()
	end
end
LoadSettings()

local function SaveSettings()
	local file = io.open(SavePath .. 'The Fixes.txt', "w")
	if file then
		file:write(json.encode(TheFixes or {}))
		file:close()
	end
end

local function LoadLocMenu()
	local locFile = thisDir .. 'loc/en.json'
	local f,err = io.open(locFile, 'r')
	if f then
		f:close()
		LocalizationManager:load_localization_file(locFile)
	end
end
Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInit_TheFixes", LoadLocMenu)


function MenuCallbackHandler:the_fixes_toggle(item)
	local index = item._parameters.name
	if TheFixes then
		local val = item:value() == 'on'
		if val then
			TheFixes[index] = true
		else
			TheFixes[index] = false
		end
	end
end

function MenuCallbackHandler:the_fixes_save()
	SaveSettings()
end

MenuHelper:LoadFromJsonFile(thisDir .. 'main.json', TheFixes, TheFixes)

Hooks:Add("MenuManagerPopulateCustomMenus", "PopulateCustomMenus_TheFixes", function( menu_manager, nodes )
	local exclude = { last_msg_id = true, msg_func = true } 
	
	for k,v in pairs(TheFixes or {}) do 
		if not exclude[k] then
			MenuHelper:AddToggle({
									id = k,
									title = 'TF_'..k..'_title',
									desc = 'TF_'..k..'_desc',
									callback = 'the_fixes_toggle',
									value = v,
									default_value = true,
									menu_id = 'the_fixes_opt',
									localized = true
								})
		end
	end
end)


TheFixes.msg_func = function()
	if CopDamage then return end
	
	if TheFixesMessage and type(TheFixesMessage) == 'string' then
		local id, msg = TheFixesMessage:match('^(%d+) (.+)')
		
		if id and msg and TheFixes and id ~= TheFixes.last_msg_id then
			QuickMenu:new("The Fixes", 
							msg,
						  {{
							text = 'OK',
							is_cancel_button = true
							}}	
			):Show()
			
			TheFixes.last_msg_id = id
			SaveSettings()
		end
		
		TheFixesMessage = nil
	end
end