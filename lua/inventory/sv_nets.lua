inventorySystem.nets = {
    update = "inventorySystem.update", -- SERVER->CLIENT ARGUMENTS: TABLE, ENTITY
    request = "inventorySystem.request", -- CLIENT->SERVER ARGUMENS: ENTITY
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