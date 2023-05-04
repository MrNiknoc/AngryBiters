-- add enraged types of all units. this should be at the bottom of the file so that we put our custom units in first and this can create
-- enraged versions of those.
local enragedUnits = {}
for name, prototype in pairs(data.raw.unit) do
    if string.find(name, "ab%-enraged%-") then goto continue end
    local enragedUnit = table.deepcopy(data.raw["unit"][name])
    local nameWords = {}
    for word in string.gmatch(enragedUnit.name, "%w*") do
        table.insert(nameWords, word)
    end
    enragedUnit.name = "ab-enraged-" .. string.gsub(enragedUnit.name, "ab%-enraged%-", "")
    enragedUnit.localised_name = "Enraged"
    for _, word in pairs(nameWords) do
        word = string.lower(word)
        if word ~= "ab" then
            enragedUnit.localised_name = enragedUnit.localised_name .. " " .. word
        end
    end

    -- enraged units run twice as fast.
    if enragedUnit.movement_speed then
        enragedUnit.movement_speed = enragedUnit.movement_speed * 2
    end
    -- tint all the run animation layers
    if enragedUnit.run_animation then
        if enragedUnit.run_animation.layers then
            for _, layer in pairs(enragedUnit.run_animation.layers) do
                local tint = {r=1}
                layer.tint = tint
                if layer.hr_version then
                    layer.hr_version.tint = tint
                end
            end
        end
    end
    -- tint all the attack animation layers
    if enragedUnit.attack_parameters then
        if enragedUnit.attack_parameters.animation then
            if enragedUnit.attack_parameters.animation.layers then
                for _, layer in pairs(enragedUnit.attack_parameters.animation.layers) do
                    local tint = {r=1}
                    layer.tint = tint
                    if layer.hr_version then
                        layer.hr_version.tint = tint
                    end
                end
            end
        end
    end
    -- I'm leaving the death animation layers, a dead enraged big biter is just a big biter.

    -- enraged units pursue 4x as far
    if enragedUnit.max_pursue_distance then
        enragedUnit.max_pursue_distance = enragedUnit.max_pursue_distance * 4
    end

    -- attack twice as fast
    if enragedUnit.attack_parameters.cooldown then
        enragedUnit.attack_parameters.cooldown = math.max(enragedUnit.attack_parameters.cooldown / 2, 1)
    end

    -- and heal twice as fast, some units may not heal at all so make them heal 0.01 per tick.
    if enragedUnit.healing_per_tick then
        enragedUnit.healing_per_tick = enragedUnit.healing_per_tick * 2
    else
        enragedUnit.healing_per_tick = 0.01
    end
    enragedUnit.order = enragedUnit.name
    table.insert(enragedUnits, enragedUnit)
    ::continue::
end
data:extend(enragedUnits)