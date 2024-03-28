inventorySystem.callPanel = function()
    inventoryFrame = vgui.Create("DFrame")
    inventoryFrame:SetTitle("Inventory")
    inventoryFrame:SetSize( 600, 500 )
    inventoryFrame:MakePopup()
    inventoryFrame:Center()

    inventoryFrame.OnClose = function( self )
        if IsValid(itemFrame) then 
            itemFrame:Remove()
        end
    end

    local scroll = vgui.Create("DScrollPanel", inventoryFrame)
    scroll:Dock(FILL)

    for k, v in pairs(inventory.storage) do
        local itemData = inventorySystem.items[v.id]

        local itemButton = vgui.Create("DButton", scroll)
        itemButton:Dock(TOP)
        itemButton:DockMargin( 0, 0, 0, 5 )
        itemButton:SetText( itemData.name )

        itemButton.DoClick = function( self )
            if IsValid(itemFrame) then itemFrame:Remove() end
            itemFrame = vgui.Create("DFrame")
            itemFrame:SetSize( 200,500 )
            itemFrame:SetPos( inventoryFrame:GetX() - 205, inventoryFrame:GetY() )
            itemFrame:SetTitle( itemData.name )
            itemFrame:SetDraggable( false )
            itemFrame:MakePopup()

            local dropButton = vgui.Create("DButton", itemFrame)
            dropButton:Dock(BOTTOM)
            dropButton:SetText("Drop")

            local useButton = vgui.Create("DButton", itemFrame)
            useButton:Dock(BOTTOM)
            useButton:SetText( itemData.use.text or "Use")

        end
    end
end

hook.Add("Think", "inventory.panelmove", function()
    if IsValid(inventoryFrame) and IsValid( itemFrame ) then
        itemFrame:SetPos( inventoryFrame:GetX() - 205, inventoryFrame:GetY() )
    end
end)

concommand.Add("inventory_callpanel", inventorySystem.callPanel)