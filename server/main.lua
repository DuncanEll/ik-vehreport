local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback("ik-vehreports:server:IsVehicleOwnedByPlayer", function(_, cb, plate)
	MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE plate = ?', { plate }, function(result)
        if result[1] then cb(true) else cb(false) end
	end)
end)
local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback("ik-vehreports:server:IsVehicleOwnedByPlayer", function(_, cb, plate)
	MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE plate = ?', { plate }, function(result)
        if result[1] then cb(true) else cb(false) end
	end)
end)

-- Server-side code
RegisterServerEvent('ik-vehreports:server:GetReceipt')
AddEventHandler('ik-vehreports:server:GetReceipt', function(vehicleName, plate, engine, brakes, transmission, suspension, armor, turbo)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local mods = {
        engine = engine,
        brakes = brakes,
        transmission = transmission,
        suspension = suspension,
        armor = armor,
        turbo = turbo,
        vehname = vehicleName,
        plate = plate
    }
    local metadata = {
        label = "Bennys Receipt",
        type = string.format('Inspected By: %s %s', Player.PlayerData.charinfo.firstname, Player.PlayerData.charinfo.lastname),
        mods = mods,
        description = string.format('Vehicle: %s\nPlate: %s\nEngine: %s\nBrakes: %s\nTransmission: %s\nSuspension: %s\nArmor: %s\nTurbo: %s',
            vehicleName, plate, engine, brakes, transmission, suspension, armor, turbo)
    }
    exports.ox_inventory:AddItem(source, "receipt", 1, metadata)
end)

QBCore.Functions.CreateUseableItem("receipt", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local mods = item.metadata.mods
    TriggerClientEvent('showui', src, mods)
end)

