local P = FindMetaTable("Player")

function P:InitInventory()
    self.inventory = Inventory( 10 )
end

function P:GetInventory() // Will in all custom containers
    return self.inventory
end