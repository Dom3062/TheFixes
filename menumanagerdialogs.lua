local TF = TheFixes
if TF:CheckLoadHook("MenuManagerDialogs") or TF._hooks.NoHook_MenuManagerDialogs then
    return
end

local NoConfirmDialog = BLT.Mods:GetModByName("No Confirm Dialogs")
if NoConfirmDialog and NoConfirmDialog:GetAuthor() == "ReaperTeh, notwa, Dribbleondo" then
    TF._hooks.NoHook_MenuManagerDialogs = true
    return
end

function MenuManager:show_confirm_mission_asset_buy_all(params)
    local dialog_data = {
        title = managers.localization:to_upper_text("menu_asset_buy_all"),
        text = "",
        text_formating_color_table = {},
        use_text_formating = true
    }
    local total_cost = 0

    for _, asset_id in ipairs(params.locked_asset_ids) do
        local td = managers.assets:get_asset_tweak_data_by_id(asset_id)
        local cost = managers.money:get_mission_asset_cost_by_id(asset_id)
        -- A call to `managers.money:can_afford_mission_asset()` is missing
        local can_unlock = managers.assets:get_asset_can_unlock_by_id(asset_id) and managers.money:can_afford_mission_asset(asset_id)

        if not can_unlock then
            dialog_data.text = dialog_data.text .. "##"

            table.insert(dialog_data.text_formating_color_table, tweak_data.screen_colors.achievement_grey)
            table.insert(dialog_data.text_formating_color_table, tweak_data.screen_colors.important_1)
        end

        dialog_data.text = dialog_data.text .. "-" .. managers.localization:text(td.name_id) .. " (" .. managers.experience:cash_string(cost) .. ")"

        if td.upgrade_lock and not can_unlock then
            dialog_data.text = dialog_data.text .. "##  " .. managers.localization:text("menu_asset_buy_all_req_skill") .. "\n"
        elseif td.dlc_lock and not can_unlock then
            dialog_data.text = dialog_data.text .. "##  " .. managers.localization:text("menu_asset_buy_all_req_dlc", {
                dlc = managers.localization:text(self:get_dlc_by_id(td.dlc_lock).name_id)
            }) .. "\n"
        elseif td.money_lock and not can_unlock then -- Add a reason why you can't buy it -> not enough money
            dialog_data.text = dialog_data.text .. "##  " .. managers.localization:text("bm_menu_not_enough_cash") .. "\n"
        else
            total_cost = total_cost + cost
            dialog_data.text = dialog_data.text .. "\n"
        end
    end

    if total_cost ~= 0 then
        dialog_data.text = dialog_data.text .. "\n" .. managers.localization:text("menu_asset_buy_all_desc", {
            price = managers.experience:cash_string(total_cost)
        })
        local yes_button = {
            text = managers.localization:text("dialog_yes"),
            callback_func = params.yes_func
        }
        local no_button = {
            text = managers.localization:text("dialog_no"),
            callback_func = params.no_func,
            cancel_button = true
        }
        dialog_data.focus_button = 2
        dialog_data.button_list = {
            yes_button,
            no_button
        }
    else
        dialog_data.text = dialog_data.text .. "\n" .. managers.localization:text("menu_asset_buy_all_fail")
        local ok_button = {
            text = managers.localization:text("dialog_ok"),
            callback_func = params.ok_func,
            cancel_button = true
        }
        dialog_data.focus_button = 1
        dialog_data.button_list = {
            ok_button
        }
    end

    managers.system_menu:show(dialog_data)
end