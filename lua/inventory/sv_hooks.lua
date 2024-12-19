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
    if inventorySystem.settings.json.enabled and not file.Exists(inventorySystem.settings.json.name, "DATA") then
        print("creating directory")
        file.CreateDir(inventorySystem.settings.json.name)
    end
end)