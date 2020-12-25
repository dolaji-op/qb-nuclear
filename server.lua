DBFW = nil
TriggerEvent('DBFW:GetObject', function(obj) DBFW = obj end)

local hiddencoords = vector3(1272.15, -1711.00, 54.77)
local onDuty = 0

DBFW.Functions.CreateCallback('nuclear:getlocation', function(source, cb)
    cb(hiddencoords)
end)

DBFW.Functions.CreateCallback('nuclear:getCops', function(source, cb)
    cb(getCops())
end)

function getCops()
    local Players = DBFW.Functions.GetPlayers()
    onDuty = 0
    return 5
end

RegisterServerEvent("nuclear:GiveItem")
AddEventHandler("nuclear:GiveItem", function(x, y, z)
    local src = source
    local Player = DBFW.Functions.GetPlayer(src)
    Player.Functions.AddItem('nuclear', 10)
    TriggerClientEvent('inventory:client:ItemBox', src, DBFW.Shared.Items['nuclear'], "add")
end)

RegisterNetEvent('nuclear:updatetable')
AddEventHandler('nuclear:updatetable', function(bool)
    TriggerClientEvent('nuclear:synctable', -1, bool)
end)

RegisterServerEvent("nuclear:syncMission")
AddEventHandler("nuclear:syncMission", function(missionData)
    local missionData = missionData
    local ItemData = Player.Functions.GetItemByName("bluechip")
    TriggerClientEvent('nuclear:syncMissionClient', -1, missionData)
end)

RegisterServerEvent("nuclear:delivery")
AddEventHandler("nuclear:delivery", function()
    local src = source
    local Player = DBFW.Functions.GetPlayer(src)
    local check = Player.Functions.GetItemByName('nuclear').count

    if check >= 1 then
        Player.Functions.RemoveItem('nuclear', 1)
        Player.Functions.AddMoney('cash', Config.reward)
        TriggerClientEvent('DBFW:Notify', src, "You received ".. Config.reward .." for your job.", "success", 3500)
    elseif Config.useNotification then
        TriggerClientEvent('DBFW:Notify', src, "You have no nuclear files left.", "success", 3500)
    end
end)



