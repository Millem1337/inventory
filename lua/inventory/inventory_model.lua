Inventory = {}
Inventory.__index = Inventory

// Condition isn't saving
function Inventory:new( size, condition, storage )
    local inventory_template = {
        size = size or 20,
        condition = condition or nil,
        storage = storage or {},
    }

    setmetatable( inventory_template, Inventory )

    return inventory_template
end

function Inventory:AddItem( item ) -- Item from item_model
    if ((not IsValid(self.condition)) or (IsValid(self.condition) and self.condition( item ))) and #self.storage+1 <= self.size then
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

function Inventory:ToTable()
    local res = { storage = self.storage, size = self.size }
    return res
end

setmetatable(Inventory, {__call = Inventory.new})