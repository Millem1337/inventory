inventorySystem = {}

local function includeAll()
    local modules = file.Find("inventory/*", "LUA")
    PrintTable(modules)

    for k, v in pairs(modules) do
        if string.StartsWith("cl_", v) then
            AddCSLuaFile("inventory/" .. v)
        elseif string.StartsWith("sv_", v) then
            include("inventory/" .. v)
        else
            include("inventory/" .. v)
            AddCSLuaFile("inventory/" .. v)
        end
    end
end

includeAll()