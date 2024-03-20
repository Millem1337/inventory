hook.Add("PlayerInitialSpawn", "inventory.initialspawn", function( ply )
    ply:InitInventory()
end)