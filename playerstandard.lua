TheFixesPreventer = TheFixesPreventer or {}
if not TheFixesPreventer.second_sight_anim_playerstandard then
    local swap_func = { _check_action_primary_attack = true }
    local anims = { recoil_steelsight = 'recoil', recoil = 'recoil_steelsight' }
    local get_anim_orig = PlayerStandard.get_animation
    function PlayerStandard:get_animation(anim, ...)
        if self._state_data.in_steelsight
            and anims[anim]
            and swap_func[debug.getinfo(2, 'n').name]
        then
            anim = anims[anim]
        end
    	return get_anim_orig(self, anim, ...)
    end
end
