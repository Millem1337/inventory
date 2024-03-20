inventorySystem = {}

local function includeAll()
    local modules = file.Find("inventory/*", "LUA")
    PrintTable(modules)

    for k, v in pairs(modules) do
        include("inventory/" .. v)
    end
end

includeAll()