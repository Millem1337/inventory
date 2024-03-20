Inventory = {}
Inventory.__index = Inventory

function Inventory:new( size, condition, storage )
    local inventory_template = {
        size = size or 20,
        condition = condition or nil,
        storage = storage or {},
    }

    setmetatable( inventory_template, Item )

    return inventory_template
end

function Inventory:AddItem( item ) -- Item from item model
    if (IsValid(self.condition) and self.condition) or (not IsValid(self.condition( item ))) and #self.storage+1 <= self.size then
        table.insert( self.storage, item )
    end
end

function Inventory:RemoveItem( item ) -- Item, ITEM NOT INDEX!
    for k, v in pairs(self.storage) do
        if (v == item) then
            table.remove(self.storage, k)
            break -- To stop searchin items
        end
    end
end

setmetatable(Inventory, {__call = Inventory.new})