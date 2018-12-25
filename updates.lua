if not BLT or 
	not BLT.Mods or
	not BLT.Mods.mods or
	not BLTUpdate or
	not BLT.Downloads or 
	not BLT.Downloads._downloads then
	return	
end

if CopDamage then return end

local TheFixesLog = function(txt)
	log('[The Fixes] ' .. tostring(txt))
end

local data = {
		modworkshop_id = 23732,
		dl_url = 'https://bitbucket.org/andole/the-fixes/raw/updates/the-fixes-latest.zip',
		info_url = 'https://bitbucket.org/andole/the-fixes/raw/updates/info.json'
	}
	
local function CompareVersion()
	local inx, thisMod, mwsID, dl_url, info_url = nil, nil, data.modworkshop_id, (data.dl_url or nil), (data.info_url or nil)
	local mwsIDs = tostring(mwsID)
	
	thisMod = BLT.Mods:GetMod(debug.getinfo(1, "S").source:sub(2):match('mods/(.-)/'))
	
	if thisMod and not thisMod.updates_checked then
		thisMod.updates_checked = true
		
		local update = BLTUpdate:new(thisMod, 
			{
				identifier = mwsID,
				disallow_update = 'upd_mws_clbk' .. mwsID
			}
		)
		local url = {
			d = 'https://modworkshop.net/mydownloads/downloads/',
			i = 'https://manager.modworkshop.net/GetSingleDownload/'.. mwsID ..'.json',
			n = 'https://modworkshop.net/mydownloads.php?action=view_down&did='.. mwsID ..'#changelog'
		}
		if info_url then
			url.i = info_url
		end
		update._server_hash = '000'
		function update:DisallowsUpdate()
			if debug.getinfo(2,'n').name == 'download_all' then
				return false
			end
			return true
		end
		function update:GetDisallowCallback()
			return 'upd_mws_clbk'..mwsID
		end
		function update:ViewPatchNotes()
			if Steam:overlay_enabled() then
				Steam:overlay_activate("url", url.n)
			else
				os.execute("cmd /c start " .. url.n)
			end
		end
		if not BLT.Downloads.the_fixes_clbk_dwnld_fin_no_ver then
			function BLT.Downloads:the_fixes_clbk_dwnld_fin_no_ver(data, http_id)
				local download = BLT.Downloads:get_download_from_http_id(http_id)
				TheFixesLog(string.format("[Downloads] Finished download of %s (%s)", download.update:GetName(), download.update:GetParentMod():GetName()))
				BLT.Downloads._coroutine_ws = BLT.Downloads._coroutine_ws or managers.gui_data:create_fullscreen_workspace()
				download.coroutine = BLT.Downloads._coroutine_ws:panel():panel({})
				local save = function()
					local wait = function( x )
						for i = 1, (x or 5) do
							coroutine.yield()
						end
					end
					local install_dir = download.update:GetInstallDirectory()
					local temp_dir = Application:nice_path( install_dir .. "_temp" )
					if install_dir == BLTModManager.Constants:ModsDirectory() then
						temp_dir = Application:nice_path( BLTModManager.Constants:DownloadsDirectory() .. "_temp" )
					end
					local file_path = Application:nice_path( BLTModManager.Constants:DownloadsDirectory() .. tostring(download.update:GetId()) .. ".zip" )
					local temp_install_dir = Application:nice_path( temp_dir .. "/" .. download.update:GetInstallFolder() )
					local install_path = Application:nice_path( download.update:GetInstallDirectory() .. download.update:GetInstallFolder() )
					local extract_path = Application:nice_path( temp_install_dir .. "/" .. download.update:GetInstallFolder() )
					local cleanup = function()
						SystemFS:delete_file( temp_install_dir )
					end
					wait()
					SystemFS:make_dir( temp_dir )
					SystemFS:delete_file( file_path )
					cleanup()
					TheFixesLog("[Downloads] Saving to downloads...")
					download.state = "saving"
					wait()
					local f = io.open( file_path, "wb+" )
					if f then
						f:write( data )
						f:close()
					end
					TheFixesLog("[Downloads] Extracting...")
					download.state = "extracting"
					wait()
					unzip(file_path, temp_install_dir)
					wait()
					TheFixesLog("[Downloads] Going on unverified...")
					TheFixesLog("[Downloads] Removing old installation...")
					wait()
					
					local old_install_path = install_path .. '_old'
					if file.MoveDirectory( install_path, old_install_path ) then
						SystemFS:delete_file( old_install_path )
					else
						SystemFS:delete_file( install_path )
					end
					
					local move_success = file.MoveDirectory(extract_path, install_path)
					if not move_success then
						if jit and jit.os and not jit.os:lower():match('linux') then
							TheFixesLog("[Downloads] BLT failed to move the folder. Moving with Windows means...")
							os.execute('move "'..extract_path..'" "'..install_path..'"')
						else
							TheFixesLog("[Downloads] Failed to move installation directory!")
							download.state = "failed"
							cleanup()
							return
						end
					end
					
					TheFixesLog("[Downloads] Complete!")
					download.state = "complete"
					cleanup()
				end
				download.coroutine:animate( save )
				MenuCallbackHandler['upd_mws_clbk'..mwsID] = nil
			end
		end
		MenuCallbackHandler['upd_mws_clbk'..mwsID] = function(this)
			local http_id = dohttpreq(url.d,
				callback(BLT.Downloads, BLT.Downloads, "the_fixes_clbk_dwnld_fin_no_ver"),
				callback(BLT.Downloads, BLT.Downloads, "clbk_download_progress")
			)
			local download = {
				update = update,
				http_id = http_id,
				state = "waiting"
			}
			table.insert(BLT.Downloads._downloads, download)
		end
		local function ParseInfo(text, id, message)
			if text:is_nil_or_empty() then
				return
			end
			if not text:find('version') then
				return
			end
			
			local req_upd = false
			local success = true
			local data = json.decode(text)
			if dl_url and info_url then
				data[mwsIDs] = data
				data[mwsIDs].download = dl_url
			end
			if data and data[mwsIDs] and data[mwsIDs].download and thisMod.version and data[mwsIDs].version then
				if tostring(thisMod.version) ~= tostring(data[mwsIDs].version) then
					url.d = url.d .. data[mwsIDs].download
					if dl_url then
						url.d = dl_url
					end
					req_upd = true
					
					BLT.Mods:clbk_got_update(update, true)
				else
					MenuCallbackHandler['upd_mws_clbk'..mwsIDs] = nil
				end
				
				if data[mwsIDs].message then
					TheFixesMessage = data[mwsIDs].message
				end
				
				if TheFixes and TheFixes.msg_func then
					TheFixes.msg_func()
				end
			else
				success = false
			end
			if message then
				local dialog = {}
				dialog.title = thisMod.name
				local bOk = {
					text = 'OK',
					cancel_button = true
				}
				dialog.button_list = {bOk}
				if success then
					if req_upd then
						dialog.text = 'An update is available!'
						local bDownload = {
							text = 'Open download manager',
							callback_func = function()
								managers.menu:open_node('blt_download_manager')
								end
						}	
						dialog.button_list = {bDownload, dialog.button_list[1]}
					else
						dialog.text = 'The latest version is installed.'
					end
				else
					dialog.text = 'Unable to check updates. No valid data received.'
				end
				managers.system_menu:show(dialog)
			end
		end
		
		thisMod.GetUpdates = function()
			return {update}
		end
		thisMod.CheckForUpdates = function(clbk)
			if thisMod.upd_checking then
				return
			end
			thisMod.upd_checking = true
			dohttpreq(url.i, function(text, id)
				thisMod.upd_checking = nil
				ParseInfo(text, id, true)
			end)
		end
		thisMod.IsCheckingForUpdates = function()
			return thisMod.upd_checking or false
		end
		
		dohttpreq(url.i, function(text, id)
			ParseInfo(text, id)
		end)
	end
end

local run_upd_chk_orig = BLT.Mods._RunAutoCheckForUpdates
BLT.Mods._RunAutoCheckForUpdates = function(...)
	run_upd_chk_orig(...)
	CompareVersion()
end