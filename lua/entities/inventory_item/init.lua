include("shared.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

function ENT:Initialize()
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS )
    self:SetUseType( SIMPLE_USE )
end

function ENT:SetItem( item )
    self:SetModel( inventorySystem.items[item.id].model )
    self.item = item
end

function ENT:Use( activator )
    activator:GetInventory():AddItem( self.item )
    activator:UpdateInventory()

    self:Remove()
end