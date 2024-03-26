inventorySystem.nets = {
    update = "inventorySystem.update", // SERVER->CLIENT ARGUMENTS: TABLE, ENTITY
    request = "inventorySystem.request", // CLIENT->SERVER ARGUMENS: ENTITY
    drop = "inventorySystem.drop", // CLIENT->SERVER ARGUMENTS: INT( INDEX OF ITEM )
    use = "inventorySystem.use", // CLIENT->SERVER ARGUMENTS: INT( INDEX OF ITEM )
}

function RequestInventory( ent )
    net.Start( inventorySystem.nets.request )
        net.WriteEntity( ent )
    net.SendToServer()
end

function DropItem( index )
    net.Start( inventorySystem.nets.drop )
        net.WriteInt( index, 32 )
    net.SendToServer()
end

function UseItem( index )
    net.Start( inventorySystem.nets.use )
        net.WriteInt( index, 32 )
    net.SendToServer()
end

net.Receive( inventorySystem.nets.update, function()
    local ent = net.ReadEntity()
    local rInventory = net.ReadTable()

    if ent == LocalPlayer() then
        inventory = rInventory
    else
        ent.inventory = rInventory
    end

    print("Running inventorySystem.update")
    hook.Run("inventorySystem.update", ent, rInventory)
end )
