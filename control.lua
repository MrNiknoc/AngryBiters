-- Angry Biters by MrNiknoc written on the last day of 2022
-- May 2023 prove fruitful and fun!

function EntityDamaged(event)
    local entity = event.entity
    local surface = entity.surface
    local position = entity.position
    local name = entity.name
    local final_health = event.final_health
    -- if this is an active unit being damaged
    if (entity.type == "unit" or entity.type == "turret") and entity.active then
        -- and it's at sub 50% hp
        if entity.get_health_ratio() < 0.5 then
            -- and it doesn't die
            if final_health > 0 then
                local enragedName = "ab-enraged-" .. name
                -- and an enraged version of the entity exists
                if game.entity_prototypes[enragedName] then
                    -- replace it with the enraged version of it.
                    local direction = entity.direction
                    local force = entity.force
                    entity.destroy()
                    local enragedEntity = surface.create_entity({name = enragedName, position = position, direction = direction, force = force})
                    enragedEntity.health = final_health
                end
            end
        elseif entity.get_health_ratio() > 0.6 then
            if string.find(name, "ab%-enraged") then
                local direction = entity.direction
                local force = entity.force
                local nonEnragedName = string.gsub(entity.name, "ab%-enraged%-", "")
                entity.destroy()
                local nonEnragedEntity = surface.create_entity({name = nonEnragedName, position = position, direction = direction, force = force})
            end
        end
    end
end

function OnTick(event)
    -- every tick check one chunk on a random surface for enraged things that shouldn't be.
    local randomSurfaceIndex = math.random(#game.surfaces)
    local surface = game.surfaces[randomSurfaceIndex]
    local chunk = surface.get_random_chunk()
    --game.print("Checking the chunk at X: " .. chunk.x .. " Y: " .. chunk.y)
    local turrets = surface.find_entities_filtered({type="turret", position = {x=chunk.x*32, y=chunk.y*32}, radius=32})
    local units = surface.find_entities_filtered({type="unit", position = {x=chunk.x*32, y=chunk.y*32}, radius = 32})
    -- check if we found one
    if next(turrets) ~= nil then
        --game.print("Turret(s) found!")
        -- we found at least one.
        for _, turret in pairs(turrets) do
            if string.find(turret.name, "ab%-enraged") then
                    -- and it's enraged
                if turret.get_health_ratio() > 0.6 then
                    -- and its health is greater than 60%
                    -- so destroy it and replace it with a non enraged version.
                    --game.print("Replacing " .. turret.name .. " with non enraged version.")
                    local position = turret.position
                    local direction = turret.direction
                    local health = turret.health
                    local force = turret.force
                    local nonEnragedName = string.gsub(turret.name, "ab%-enraged%-", "")
                    turret.destroy()
                    local nonEnragedEntity = surface.create_entity({name = nonEnragedName, position = position, direction = direction, force = force})
                    nonEnragedEntity.health = health
                end
            end
        end
    end

    if next(units) ~= nil then
        --game.print("Found units.")
        for _, unit in pairs(units) do
            if string.find(unit.name, "ab%-enraged") then
                --game.print("Found enraged unit.")
                if unit.get_health_ratio() > 0.6 then
                    --game.print("Replacing " .. unit.name .. " with non enraged version.")
                    local position = unit.position
                    local direction = unit.direction
                    local health = unit.health
                    local force = unit.force
                    local nonEnragedName = string.gsub(unit.name, "ab%-enraged%-", "")
                    unit.destroy()
                    local nonEnragedEntity = surface.create_entity({name = nonEnragedName, position = position, direction = direction, force = force})
                    nonEnragedEntity.health = health
                end
            end
        end
    end    
end

function ChunkGenerated(event)
    -- fix any enraged worms that shouldn't be enraged in a newly generated chunk.
    local turrets = event.surface.find_entities_filtered({area = event.area, type = "turret"})
    if next(turrets) ~= nil then
        for _, turret in pairs(turrets) do
            if string.find(turret.name, "ab%-enraged") then
                -- and it's enraged
                if turret.get_health_ratio() > 0.6 then
                    -- and its health is greater than 60%
                    -- so destroy it and replace it with a non enraged version.
                    --game.print("Replacing " .. turret.name .. " with non enraged version.")
                    local position = turret.position
                    local direction = turret.direction
                    local nonEnragedName = string.gsub(turret.name, "ab%-enraged%-", "")
                    turret.destroy()
                    local nonEnragedEntity = event.surface.create_entity({name = nonEnragedName, position = position, direction = direction})
                end
            end
        end
    end
end

function PlayerCreated(event)
    local player = game.get_player(event.player_index)
    if player and player.connected then
        if not script.active_mods["WhatLiesWithin"] then
            player.print("[color=1,0,0]Angry Biters[/color] enabled. Join us on Discord: [color=0,1,0]https://discord.gg/q3tSrs3uRy[/color]")
            player.print("If anything is enraging and shouldn't, or the opposite, let me know on the mod portal or discord!")
        end
    end
end

script.on_event(defines.events.on_entity_damaged, EntityDamaged)
script.on_event(defines.events.on_tick, OnTick)
script.on_event(defines.events.on_chunk_generated, ChunkGenerated)
script.on_event(defines.events.on_player_created, PlayerCreated)