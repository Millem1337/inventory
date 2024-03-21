local P = FindMetaTable("Player")

function P:LoadInventory()
    print("Loading " .. self:SteamID64() .. " inventory!")
    if inventorySystem.settings.sqlite.enabled then
        temp_inventory = self:SQLGetInventory()
        if not temp_inventory then
            self:SQLCreateInventory()
            self.inventory = Inventory()
        else
            temp_inventory = util.JSONToTable(temp_inventory)
            self.inventory = Inventory( tonumber(temp_inventory.size) ) // tonumber is for except any errors

            for k, v in pairs(temp_inventory.storage or {}) do
                self:GetInventory():AddItem( Item( v.id, v.data or {} ) )
            end
        end
    end

    self:UpdateInventory() // To send information about inventory to client
end

function P:SQLUpdateInventory()
    sql.Query( "UPDATE " .. inventorySystem.settings.sqlite.name .. " SET inventory=".. SQLStr(util.TableToJSON(self:GetInventory():ToTable())) .. " WHERE steamid=" .. SQLStr(self:SteamID64()) .. ";")
end

function P:SQLGetInventory()
    return sql.QueryValue("SELECT inventory FROM " .. inventorySystem.settings.sqlite.name .. " WHERE steamid=" .. SQLStr(self:SteamID64()))
end

function P:SQLCreateInventory()
    sql.Query( "INSERT INTO " .. inventorySystem.settings.sqlite.name .. " ( steamid, inventory ) VALUES(" .. SQLStr(self:SteamID64()) .. ", ".. SQLStr(util.TableToJSON({})) ..") " )
end