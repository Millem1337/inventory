inventorySystem.nets = {
    update = "inventorySystem.update", // SERVER->CLIENT ARGUMENTS: TABLE, ENTITY
    request = "inventorySystem.request", // CLIENT->SERVER ARGUMENS: ENTITY
    drop = "inventorySystem.drop", // CLIENT->SERVER ARGUMENTS: INT( INDEX OF ITEM )
    use = "inventorySystem.use", // CLIENT->SERVER ARGUMENTS: INT( INDEX OF ITEM )
}

for k,v in pairs( inventorySystem.nets ) do
    util.AddNetworkString( v )
end

local P = FindMetaTable("Player")

function P:UpdateInventory()
    net.Start( inventorySystem.nets.update )
        net.WriteEntity( self )
        net.WriteTable( self:GetInventory():ToTable() )
    net.Send( self )
end

net.Receive( inventorySystem.nets.request, function( _, ply )
    local ent = net.ReadEntity()

    if IsValid(ent.GetInventory) then
        net.Start( inventorySystem.nets.update )
            net.WriteEntity( ent )
            net.WriteTable( ent:GetInventory():ToTable() )
        net.Send( ply )
    end
end )

net.Receive( inventorySystem.nets.drop, function( _, ply )
    local index = net.ReadInt(32)

    if(ply:GetInventory():GetItem(index)) then
        ply:DropItem( index )
    end
end)

net.Receive( inventorySystem.nets.use, function( _, ply )
    local index = net.ReadInt(32)

    local item = ply:GetInventory():GetItem(index)

    if(item) then
        item:Use()
        ply:GetInventory():RemoveIndex( index )
    end
end)
