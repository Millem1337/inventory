inventorySystem.callPanel = function()
    if IsValid(inventoryFrame) then inventoryFrame:Remove() end

    inventoryFrame = vgui.Create("UFrame")
    inventoryFrame:SetTitle(inventorySystem.lang.main_panel)
    inventoryFrame:SetSize( 600, 500 )
    inventoryFrame:SetPos(ScrW()/2-300, ScrH()-1.5*ScrH())
    inventoryFrame:MoveTo(ScrW()/2 - 300, ScrH()/2 - 250, 1, 0, 0.2)
    inventoryFrame:MakePopup()

    inventoryFrame.OnClose = function( self )
        if IsValid(itemFrame) then 
            itemFrame:Remove()
        end
    end

    local inventoryButton = vgui.Create("UButton", inventoryFrame)
    inventoryButton:SetText(inventorySystem.lang.inventory)
    inventoryButton:SetSize( 292, 20 )
    inventoryButton:SetPos( 5, 25 )

    local passportButton = vgui.Create("UButton", inventoryFrame)
    passportButton:SetText(inventorySystem.lang.passport)
    passportButton:SetSize( 292, 20 )
    passportButton:SetPos( 303, 25 )

    passportButton.DoClick = function()
        if IsValid(scroll) then
            scroll:Remove()
        end

        if IsValid(itemFrame) then
            itemFrame:Remove()
        end

        if IsValid(passportPanel) then return end

        passportPanel = vgui.Create("DPanel", inventoryFrame)
        passportPanel:DockMargin(0,25,0,0)
        passportPanel:Dock(FILL)
    end

    inventoryButton.DoClick = function()
        if IsValid(passportPanel) then 
            passportPanel:Remove()
        end

        if IsValid(scroll) then return end

        scroll = vgui.Create("DScrollPanel", inventoryFrame)
        scroll:DockMargin(0,25,0,0)
        scroll:Dock(FILL)

        PopulateInventory( scroll, inventory.storage )
    end

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
            dropButton:SetText( inventorySystem.lang.drop )

            dropButton.DoClick = function( self )
                DropItem( k )
            end

            local useButton = vgui.Create("UButton", itemFrame)
            useButton:Dock(BOTTOM)
            useButton:SetText( itemData.use.text or inventorySystem.lang.use )

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