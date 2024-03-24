local P = FindMetaTable("Player")

function P:GetInventory() // Will in all custom containers
    return self.inventory
end

function P:DropItem( index )
    local item = self:GetInventory():GetItem( index )
    if item then
        local startPos = self:EyePos() + self:GetAimVector() * 35
        local endPos = self:GetEyeTrace().HitPos
        local item_data = inventorySystem.items[item.id]

        local ent = ents.Create("inv_item")
        ent:SetItem( item )

        ent:SetPos ( startPos )
        ent:Spawn()
        
        local phys = ent:GetPhysicsObject()
        if IsValid(phys) then
            phys:Wake()
            phys:EnableMotion( true )
            phys:ApplyForceCenter((endPos - startPos):GetNormalized() * 300)
        end
    end
end