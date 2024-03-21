Item = {}
Item.__index = Item

function Item:new( id, data )
    local item_template = {
        id = id or "nothing",
        data = data or {},
    }

    setmetatable( item_template, Item )

    return item_template
end

setmetatable(Item, {__call = Item.new})
