inventorySystem = {}

local function includeAll()
    local modules = file.Find("inventory/*", "LUA")
    PrintTable(modules)

    for k, v in pairs(modules) do
        if string.StartsWith(v, "cl_") then
            AddCSLuaFile("inventory/" .. v)
        elseif string.StartsWith(v, "sv_") then
            include("inventory/" .. v)
        else
            include("inventory/" .. v)
            AddCSLuaFile("inventory/" .. v)
        end
    end
end

includeAll()