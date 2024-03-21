hook.Add("PlayerInitialSpawn", "inventory.initialspawn", function( ply )
    ply:LoadInventory()
end)

hook.Add("PlayerDisconnected", "inventory.save", function( ply )
    if inventorySystem.settings.sqlite.enabled then
        ply:SQLUpdateInventory()
    end
end)

hook.Add("Initialize", "inventory.initialize", function()
    if inventorySystem.settings.sqlite.enabled then
        sql.Query("CREATE TABLE IF NOT EXISTS " .. inventorySystem.settings.sqlite.name .. " ( steamid TEXT, inventory TEXT )")
    end
end)