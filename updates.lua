if not BLT or 
	not BLT.Mods or
	not BLT.Mods.mods or
	not BLTUpdate or
	not BLT.Downloads or 
	not BLT.Downloads._downloads then
	return	
end

local mwsID = '23732'

Steam:http_request(
		'https://modworkshop.net/mydownloads.php?action=view_down&did='..mwsID,
				function(success, body)
					if success then
						local ver = body:match('<strong>Version ([%d%.]+)</strong>')

						if ver and BLT and BLT.Mods and BLT.Mods.GetMod then
							
							local thisMod = BLT.Mods:GetMod(debug.getinfo(1, "S").source:sub(2):match('mods/(.-)/'))
							local curver = thisMod and thisMod:GetVersion() or ''
							
							if ver ~= curver then
								local update = BLTUpdate:new(thisMod, 
													{
														identifier = mwsID,
														disallow_update = 'upd_mws_clbk' .. mwsID
													})
								function update:DisallowsUpdate()
									return false
								end
								
								function update:ViewPatchNotes()
									local url = 'https://modworkshop.net/mydownloads.php?action=view_down&did='.. mwsID ..'#changelog'
									if Steam:overlay_enabled() then
										Steam:overlay_activate("url", url)
									else
										os.execute("cmd /c start " .. url)
									end
								end
								
								function update:CheckForUpdates()
								end
								
								MenuCallbackHandler['upd_mws_clbk'..mwsID] = function(this)

								end
								
								local download = {
									update = update,
									http_id = mwsID,
									state = "You can update this mod on modworshop.net"
								}
								table.insert(BLT.Downloads._downloads, download)
								
								local origfunc = BLTDownloadControl.init
								function BLTDownloadControl:init(panel, parameters, ...)
									origfunc(self, panel, parameters, ...)
									if parameters.update == update and self._download_state then
										self._download_state:set_text('Update this mod manually from modworkshop.net')
									end
								end
								
								thisMod.GetUpdates = function()
									return {update}
								end
								
								BLT.Mods:clbk_got_update(update, true)
							end
						end
					end
				end
			)