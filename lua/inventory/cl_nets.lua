inventorySystem.nets = {
    update = "inventorySystem.update", // SERVER->CLIENT ARGUMENTS: TABLE, ENTITY
    request = "inventorySystem.request", // CLIENT->SERVER ARGUMENS: ENTITY
}

function RequestInventory( ent )
    net.Start( inventorySystem.nets.request )
        net.WriteEntity( ent )
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
end )
