TheFixesPreventer = TheFixesPreventer or {}
local on_enemy_died_orig = EnemyManager.on_enemy_died
function EnemyManager:on_enemy_died(dead_unit, damage_info, ...)
	on_enemy_died_orig(self, dead_unit, damage_info, ...)
    
    if damage_info.is_fire_dot_damage and (not TheFixes or TheFixes.fire_dot) then
        local data = {
            name = dead_unit:base()._tweak_table,
            stats_name = dead_unit:base()._stats_name,
            head_shot = false,
            weapon_unit = damage_info.weapon_unit,
            variant = damage_info.variant
        }
        managers.statistics:killed(data)
    end
end