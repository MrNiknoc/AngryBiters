-- This is where we create prototypes for enraged turrets (specifically worms)

local enragedTurrets = {}
for name, prototype in pairs(data.raw.turret) do
    if string.find(name, "ab%-enraged%-") then goto continue end
    local enragedTurret = table.deepcopy(data.raw["turret"][name])
    local nameWords = {}
    for word in string.gmatch(enragedTurret.name, "%w*") do
        table.insert(nameWords, word)
    end
    enragedTurret.name = "ab-enraged-" .. enragedTurret.name
    enragedTurret.localised_name = "Enraged"
    for _, word in pairs(nameWords) do
        if word ~= "ab" and word ~= "turret" then
            enragedTurret.localised_name = enragedTurret.localised_name .. " " .. word
        end
    end

    -- TINT ANIMATION LAYERS
    -- all animations are optional so check if they exist first.
    if enragedTurret.folded_animation then
        if enragedTurret.folded_animation.layers then
            for _, layer in pairs(enragedTurret.folded_animation.layers) do
                local tint = {r=1}
                layer.tint = tint
                if layer.hr_version then
                    layer.hr_version.tint = tint
                end
            end
        end
    end

    if enragedTurret.preparing_animation then
        -- tint the preparing animation
        if enragedTurret.prepared_animation.layers then
            for _, layer in pairs(enragedTurret.preparing_animation.layers) do
                local tint = {r=1}
                layer.tint = tint
                if layer.hr_version then
                    layer.hr_version.tint = tint
                end
            end
        end
    end

    if enragedTurret.prepared_animation then
        -- tint the prepared animation
        if enragedTurret.prepared_animation.layers then
            for _, layer in pairs(enragedTurret.prepared_animation.layers) do
                local tint = {r=1}
                layer.tint = tint
                if layer.hr_version then
                    layer.hr_version.tint = tint
                end
            end
        end
    end

    if enragedTurret.prepared_alternative_animation then
        -- tint the prepared_alternative animation
        if enragedTurret.prepared_alternative_animation.layers then
            for _, layer in pairs(enragedTurret.prepared_alternative_animation.layers) do
                local tint = {r=1}
                layer.tint = tint
                if layer.hr_version then
                    layer.hr_version.tint = tint
                end
            end
        end
    end

    if enragedTurret.starting_attack_animation then
        -- tint the starting_attack animation
        if enragedTurret.starting_attack_animation.layers then
            for _, layer in pairs(enragedTurret.starting_attack_animation.layers) do
                local tint = {r=1}
                layer.tint = tint
                if layer.hr_version then
                    layer.hr_version.tint = tint
                end
            end
        end
    end

    if enragedTurret.ending_attack_animation then
        -- tint the ending_attack animation
        if enragedTurret.ending_attack_animation.layers then
            for _, layer in pairs(enragedTurret.ending_attack_animation.layers) do
                local tint = {r=1}
                layer.tint = tint
                if layer.hr_version then
                    layer.hr_version.tint = tint
                end
            end
        end
    end

    if enragedTurret.folding_animation then
        -- tint the folding animation
        if enragedTurret.folded_animation.layers then
            for _, layer in pairs(enragedTurret.folding_animation.layers) do
                local tint = {r=1}
                layer.tint = tint
                if layer.hr_version then
                    layer.hr_version.tint = tint
                end
            end
        end
    end

    if enragedTurret.call_for_help_radius then
        enragedTurret.call_for_help_radius = enragedTurret.call_for_help_radius * 2
    end
    if enragedTurret.healing_per_tick then
        enragedTurret.healing_per_tick = enragedTurret.healing_per_tick * 2
    end
    if enragedTurret.rotation_speed then
        enragedTurret.rotation_speed = enragedTurret.rotation_speed * 2
    end
    if enragedTurret.preparing_speed then
        enragedTurret.preparing_speed = enragedTurret.preparing_speed * 2
    end
    if enragedTurret.folded_speed then
        enragedTurret.folded_speed = enragedTurret.folded_speed * 2
    end
    if enragedTurret.folded_speed_secondary then
        enragedTurret.folded_speed_secondary = enragedTurret.folded_speed_secondary * 2
    end
    if enragedTurret.prepared_speed then
        enragedTurret.prepared_speed = enragedTurret.prepared_speed * 2
    end
    if enragedTurret.prepared_speed_secondary then
        enragedTurret.prepared_speed_secondary = enragedTurret.prepared_speed_secondary * 2
    end
    if enragedTurret.prepared_alternative_speed then
        enragedTurret.prepared_alternative_speed = enragedTurret.prepared_alternative_speed * 2
    end
    if enragedTurret.prepared_alternative_speed_secondary then
        enragedTurret.prepared_alternative_speed_secondary = enragedTurret.prepared_alternative_speed_secondary * 2
    end
    if enragedTurret.starting_attack_speed then
        enragedTurret.starting_attack_speed = enragedTurret.starting_attack_speed * 2
    end
    if enragedTurret.attacking_speed then
        enragedTurret.attacking_speed = enragedTurret.attacking_speed * 2
    end
    if enragedTurret.ending_attack_speed then
        enragedTurret.ending_attack_speed = enragedTurret.ending_attack_speed * 2
    end
    if enragedTurret.folding_speed then
        enragedTurret.folding_speed = enragedTurret.folding_speed * 2
    end
    if enragedTurret.attack_parameters then
        if enragedTurret.attack_parameters.range then
            enragedTurret.attack_parameters.range = enragedTurret.attack_parameters.range * 2
        end
        if enragedTurret.attack_parameters.cooldown then
            enragedTurret.attack_parameters.cooldown = math.max(1, enragedTurret.attack_parameters.cooldown/2)
        end
    end
    table.insert(enragedTurrets, enragedTurret)
    ::continue::
end
data:extend(enragedTurrets)