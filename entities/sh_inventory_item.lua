ENT = {}

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Inventory item"
ENT.Author = "Millem"
ENT.Instructions = "..."

if SERVER then
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
        activator:UpdateInv()

        self:Remove()
    end
end

scripted_ents.Register(ENT, "inv_item")