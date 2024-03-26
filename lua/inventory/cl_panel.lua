inventorySystem.callPanel = function()
    if IsValid(inventoryFrame) then inventoryFrame:Remove() end

    inventoryFrame = vgui.Create("UFrame")
    inventoryFrame:SetTitle("Inventory")
    inventoryFrame:SetSize( 600, 500 )
    inventoryFrame:SetPos(ScrW()/2-300, ScrH()-1.5*ScrH())
    inventoryFrame:MoveTo(ScrW()/2 - 300, ScrH()/2 - 250, 1, 0, 0.2)
    inventoryFrame:MakePopup()

    inventoryFrame.OnClose = function( self )
        if IsValid(itemFrame) then 
            itemFrame:Remove()
        end
    end

    local scroll = vgui.Create("DScrollPanel", inventoryFrame)
    scroll:Dock(FILL)

    PopulateInventory( scroll, inventory.storage )

    hook.Add("inventorySystem.update", "inventory.update", function( _, tInventory )
        if not IsValid(scroll) then return end
        
        if IsValid(itemFrame) then itemFrame:Remove() end

        PrintTable(tInventory.storage)

        PopulateInventory( scroll, tInventory.storage )
    end)
end

function PopulateInventory( scroll, tInventory )
    scroll:Clear()

    for k, v in pairs(tInventory) do
        local itemData = inventorySystem.items[v.id]

        local itemButton = vgui.Create("UButton", scroll)
        itemButton:Dock(TOP)
        itemButton:DockMargin( 0, 0, 0, 5 )
        itemButton:SetText( itemData.name )

        itemButton.DoClick = function( self )
            if IsValid(itemFrame) then itemFrame:Remove() end
            itemFrame = vgui.Create("UFrame")
            itemFrame:SetSize( 200,500 )
            itemFrame:SetPos( inventoryFrame:GetX() - 205, inventoryFrame:GetY() )
            itemFrame:SetTitle( itemData.name )
            itemFrame:SetDraggable( false )
            itemFrame:MakePopup()

            local description = vgui.Create("RichText", itemFrame)
            description:Dock(TOP)
            description:AppendText( itemData.description )
            description:SetVerticalScrollbarEnabled( false )
            description.PerformLayout = function( self )

                self:SetFontInternal( "ui.main" )
                self:SetFGColor( color_white )
                
            end

            local dropButton = vgui.Create("UButton", itemFrame)
            dropButton:Dock(BOTTOM)
            dropButton:SetText("Выкинуть")

            dropButton.DoClick = function( self )
                DropItem( k )
            end

            local useButton = vgui.Create("UButton", itemFrame)
            useButton:Dock(BOTTOM)
            useButton:SetText( itemData.use.text or "Использовать")

            useButton.DoClick = function( self )
                UseItem( k )
            end
        end
    end
end

hook.Add("Think", "inventory.panelmove", function()
    if IsValid(inventoryFrame) and IsValid( itemFrame ) then
        itemFrame:SetPos( inventoryFrame:GetX() - 205, inventoryFrame:GetY() )
    end
end)

concommand.Add("inventory_callpanel", inventorySystem.callPanel)