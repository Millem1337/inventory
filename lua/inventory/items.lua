inventorySystem.items = {
    nothing = { // Key=id
        name = "Nothing",
        description = "Nothing is nothing :)",
        model = "models/props_combine/breenglobe.mdl",
        use = {
            text = nil, // nil will remove use button in ui
            func = function( ply, data ) print(ply:SteamID64() .. " used nothing :)") end,
        }
    }
}

// TODO: Make itemdata model