local MenuPath = TheFixes and (TheFixes.ModPath .. "menu/") or (ModPath .. "menu/")

local _languages = { "blt", "en", "cn", "de", "it", "ru", "th", "es", "cs" }

-- If there is no BLT
if not MenuHelper then
	return
end

local function SaveSettings()
	local file = io.open(SavePath .. 'The Fixes.txt', "w")
	TheFixes = TheFixes or {}
	TheFixes.override = TheFixesPreventerOverride or {}
	if file then
		file:write(json.encode(TheFixes or {}))
		file:close()
	end
end

local function GetBestLanguageCode()
	local lang = 'en'

	if not TheFixes.language then
		TheFixes.language = 1
	end

	if _languages[TheFixes.language] and _languages[TheFixes.language] == 'blt' then
		if BLT and BLT.Localization and BLT.Localization.get_language then
			lang = BLT.Localization:get_language().language or 'en'
		end

		if BLT and BLT.Mods and BLT.Mods.GetMod and BLT.Mods:GetMod('PD2TH') then
			lang = 'th'
		end

		if lang == 'cht' or lang == 'zh-cn' then
			lang = 'cn'
		end
	else
		lang = _languages[TheFixes.language] or 'en'
	end

	return lang or 'en'
end

local function TryLoadLocFile(filename)
	local f,err = io.open(filename, 'r')
	if f then
		f:close()
		LocalizationManager:load_localization_file(filename)
		return true
	end
	return false
end

local info_saved = false
local function LoadLocMenu()
	if not info_saved and TheFixes and TheFixes.dump_info and BLT.Mods then
		TheFixes.dump_info()
		info_saved = true
	end

	local lang = GetBestLanguageCode()
	if not TryLoadLocFile(MenuPath .. 'loc/' .. lang .. '.json') then
		TryLoadLocFile(MenuPath .. 'loc/en.json')
	end
	TryLoadLocFile(MenuPath .. 'loc/lang_names.json')
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

function MenuCallbackHandler:the_fixes_language(item)
	TheFixes.language = item:value() or 1
	LoadLocMenu()
	managers.menu:back()
	managers.menu:open_node('the_fixes_opt')
end

MenuHelper:LoadFromJsonFile(MenuPath .. 'main.json', TheFixes, TheFixes)

Hooks:Add("MenuManagerPopulateCustomMenus", "PopulateCustomMenus_TheFixes", function( menu_manager, nodes )
	local languageItems = {}
	for k,v in pairs(_languages) do
		languageItems[k] = 'the_fixes_lang_name_'..v
	end
	MenuHelper:AddMultipleChoice({
		id = 'language',
		title = 'LANGUAGE',
		desc = 'Set the preffered mod language',
		callback = 'the_fixes_language',
		items = languageItems,
		value = TheFixes.language or 1,
		default_value = 1,
		menu_id = 'the_fixes_opt',
		localized = false,
		priority = 100
	})

	local exclude = { last_msg_id = true, msg_func = true, dump_info = true, language = true, _hooks = true, _cache = true, CheckLoadHook = true, ModPath = true }
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
	if HuskPlayerMovement then return end

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

TheFixes.dump_info = function()
	if jit and jit.os and not jit.os:lower():match('linux') then
		local username = os.getenv("USERNAME")
		if not username then return end

		local info = 'Generated by The Fixes mod\n'
		local distribution = SystemInfo:distribution()
		local matchmaking = SystemInfo:matchmaking()
		if distribution == Idstring("STEAM") then
			info = info .. "Distribution: Steam\n"
		elseif distribution == Idstring("EPIC") then
			info = info .. "Distribution: EGS\n"
		else
			info = info .. "Distribution: <Unknown>\n"
		end
		if matchmaking == Idstring("MM_STEAM") then
			info = info .. "Matchmaking: Steamworks\n\n"
		elseif matchmaking == Idstring("MM_EPIC") then
			info = info .. "Matchmaking: EOS\n\n"
		else
			info = info .. "Matchmaking: <Unknown>\n\n"
		end

		info = info .. "BLT mods:\n"

		local mods = BLT.Mods:Mods()
		for k,v in ipairs(mods) do
			info = info..k..' '..(v.name or '<unknown>')..' | '..(v.version or '?')..'\n'
		end

		local counter = 1
		for k, _ in pairs(TheFixesPreventer or {}) do
			if counter == 1 then
				info = info..'\nDisabled fixes:\n'..'1 '..k..'\n'
			else
				info = info..counter..' '..k..'\n'
			end
			counter = counter + 1
		end

		for k, v in pairs(TheFixes or {}) do
			if type(v) == 'boolean' and not v then
				if counter == 1 then
					info = info..'\nDisabled fixes:\n'..'1 '..k..'\n'
				else
					info = info..counter..' '..k..'\n'
				end
				counter = counter + 1
			end
		end

		for _, v in ipairs(SystemFS:list('', true) or {}) do
			if v:lower() == 'maps' then
				info = info..'\nPAYDAY 2/Maps:\n'
				for k2,v2 in ipairs(SystemFS:list('Maps', true) or {}) do
					info = info..k2..' '..v2..'\n'
				end
				break
			end
		end

		for _, v in ipairs(SystemFS:list('assets', true) or {}) do
			if v:lower() == 'mod_overrides' then
				info = info..'\nPAYDAY 2/assets/mod_overrides:\n'
				for k2,v2 in ipairs(SystemFS:list('assets/mod_overrides', true) or {}) do
					info = info..k2..' '..v2..'\n'
				end
				break
			end
		end

		local file = io.open('C:\\Users\\'.. username ..'\\AppData\\Local\\PAYDAY 2\\The Fixes Info.txt', "w")
		if file then
			file:write(info)
			file:close()
		end
	end
end
