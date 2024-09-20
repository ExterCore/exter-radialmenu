local QBCore = exports['qb-core']:GetCoreObject()

local isJudge = false
local isPolice = false
local isTow = false
local isTaxi = false
local isMedic = false
local isDead = false
local myJob = "Unemployed"
local isHandcuffed = false
local hasOxygenTankOn = false
local bennyscivpoly = false
local onDuty = false
local inGarage = false
local inDepots = false

rootMenuConfig =  {
    {
        id = "expressions",
        displayName = "Expressions",
        icon = "#expressions",
        enableMenu = function()
            local src = source
            local Player = QBCore.Functions.GetPlayerData(src)
            local inlaststand = Player.metadata["inlaststand"]
            local isdead = Player.metadata["isdead"]

         
            return not inlaststand and not isdead
        end,
        subMenus = { "expressions:drunk", "expressions:angry", "expressions:dumb", "expressions:electrocuted", "expressions:grumpy", "expressions:happy", "expressions:injured", "expressions:joyful", "expressions:mouthbreather", "expressions:shocked", "expressions:sleeping", "expressions:smug", "expressions:speculative", "expressions:stressed", "expressions:sulking", "expressions:weird", "expressions:weird2"}
    },
    {
        id = "blips",
        displayName = "GPS",
        icon = "#blips",
        enableMenu = function()
            local src = source
            local Player = QBCore.Functions.GetPlayerData(src)
            local inlaststand = Player.metadata["inlaststand"]
            local isdead = Player.metadata["isdead"]

            return not isdead and not inlaststand
        end,
        subMenus = { "blips:gasstations", --[["blips:trainstations",]] "blips:barbershop", "blips:tattooshop", "fk:karakol", "fk:hastane", "fk:galeri", "fk:motel"}
    },
    {
        id = "General",
        displayName = "General",
        icon = "#globe-europe",
        enableMenu = function()
            local src = source
            local Player = QBCore.Functions.GetPlayerData(src)
            local inlaststand = Player.metadata["inlaststand"]
            local isdead = Player.metadata["isdead"]

            return not inlaststand and not isdead
        end,
        subMenus = {"general:givenum", "drug:sell"}
    },
    {
        id = "Interaction",
        displayName = "Interaction",
        icon = "#general",
        enableMenu = function()
            local src = source
            local Player = QBCore.Functions.GetPlayerData(src)
            local inlaststand = Player.metadata["inlaststand"]
            local isdead = Player.metadata["isdead"]

            return not isdead and not inlaststand
        end,
        
        subMenus = {"general:cuff", "general:rob", "general:playerinvehicle", "general:playeroutvehicle", }
    },
    {
        id = "copDead",
         displayName = "11-A",
         icon = "#police-dead",
         functionName = "police:client:SendPoliceEmergencyAlert",
         enableMenu = function()
            local src = source
            local Player = QBCore.Functions.GetPlayerData(src)
            local inlaststand = Player.metadata["inlaststand"]
            local isdead = Player.metadata["isdead"]

            return isPolice and inlaststand and isdead -- and onDuty 
          end,
     },
     {
     id = "k9",
     displayName = "K9",
     icon = "#k9",
     enableMenu = function()
         return (isPolice and not isDead)
     end,
     subMenus = {"k9:follow", "k9:vehicle",  "k9:sniffvehicle", "k9:huntfind", "k9:sit", "k9:stand", "k9:sniff", "k9:lay", }
    },
    {    
        id = "Police",
        displayName = "Police Interaction",
        icon = "#police-action",
        enableMenu = function()
            local src = source
            local Player = QBCore.Functions.GetPlayerData(src)
            local inlaststand = Player.metadata["inlaststand"]
            local isdead = Player.metadata["isdead"]

            return (isPolice and not isDead)
        end,
        subMenus = {"police:mdt", "general:cuff", "police:seizecash", "police:takedriverlicense", "police:statuscheck", "police:searchplayer", "police:jail", "police:takeoffmask" }
    },
    {    
        id = "PoliceObjects",
        displayName = "Police Objects",
        icon = "#police-action",
        enableMenu = function()
            local src = source
            local Player = QBCore.Functions.GetPlayerData(src)
            local inlaststand = Player.metadata["inlaststand"]
            local isdead = Player.metadata["isdead"]

            return isPolice and not isDead and onduty
        end,
        subMenus = {"police:spawn1", "police:spawn2", "police:spawn3", "police:del"}
        },
    {
    id = "Ambulance",
    displayName = "Ambulance",
    icon = "#hospital-amb",
    enableMenu = function()
        return isMedic and not isDead and onduty
    end,
    subMenus = {"medic:status", "medic:revive", "medic:treat"}
},
{
    id = "Tow",
    displayName = "Tow",
    icon = "#tow-job",
    enableMenu = function()
        local src = source
        local Player = QBCore.Functions.GetPlayerData(src)
        local inlaststand = Player.metadata["inlaststand"]
        local isdead = Player.metadata["isdead"]

        return isTow and not isDead and onduty
    end,
    subMenus = {"tow:togglenpc", "tow:vehicle"}
},
{
    id = "Taxi",
    displayName = "Taxi",
    icon = "#tow-job",
    enableMenu = function()
        local src = source
        local Player = QBCore.Functions.GetPlayerData(src)
        local inlaststand = Player.metadata["inlaststand"]
        local isdead = Player.metadata["isdead"]

        return isTaxi and not isDead and onduty
    end,
    subMenus = {"taxi:npc", "taxi-meter", "taxi:startmeter"}
},
    {    
    id = "Escort",
    displayName = "Escort",
    icon = "#general-escort",
    functionName = "police:client:EscortPlayer",
    enableMenu = function()
        local src = source
        local Player = QBCore.Functions.GetPlayerData(src)
        local inlaststand = Player.metadata["inlaststand"]
        local isdead = Player.metadata["isdead"]

        return not isdead and not inlaststand
    end
    },
    {   
        id = "Vehicle",
        displayName = "Vehicle",
        icon = "#vehicle-options-vehicle",
        functionName = "carmenuevent",
        enableMenu = function()
            return (not isDead and IsPedInAnyVehicle(PlayerPedId(), true))
        end
    },
    {
        id = "general:parkvehicle",
        displayName = "Park Vehicle",
        icon = "#general-parking",
        functionName = "qb-garages:putingarage",
        enableMenu = function()
            return (not isDead and inGarage and isCloseVeh() and not IsPedInAnyVehicle(PlayerPedId(), false))
        end
    },
    {    
        id = "Emotes",
        displayName = "Emotes",
        icon = "#general-emotes",
        functionName = "emotes:OpenMenu",
        eventType = "command",
        enableMenu = function()
            local src = source
            local Player = QBCore.Functions.GetPlayerData(src)
            local inlaststand = Player.metadata["inlaststand"]
            local isdead = Player.metadata["isdead"]

            return not isdead and not inlaststand 
        end
    },
    {
        id = "GiveKeys",
        displayName = "Give Keys",
        icon = "#general-keys-give",
        functionName = "qb-vehiclekeys:client:GiveKeys",
        enableMenu = function()
            return (isCloseVeh())
        end
    },
   {
    
        id = "general:depots",
        displayName = "Depots",
        icon = "#general-keys-give",
        functionName = "qb-garages:takeoutveh:depot",
        enableMenu = function()
            return (not isDead and inDepots and not IsPedInAnyVehicle(PlayerPedId(), false))
        end
    } -- add `,` after `}` if you gonna add new button but last button should ended w/o `,`

    -- NOTE
    -- for add a new function button to menu:
    -- {
    --     id = "generalgarage", -- type group id name, can be any name
    --     displayName = "Garage", -- Display Name
    --     icon = "#general-garage", -- Icon, should be with `#` cuz from HTML and check HTML for edits
    --     functionName = "qb-garages:takeout", -- THIS IS THE FUNCTION NAME THAT WILL BE TRIGGERED AFTER CLICKING THE BUTTON
    --     enableMenu = function()
    --         return (not isDead and inGarage and not isCloseVeh() and not IsPedInAnyVehicle(PlayerPedId(), false)) -- if person is dead or in vehicle. we don't want dead people to see this button if dead
    --     end
    -- }

    -- for open a new menu from the button:
    -- {
    --     id = "general", -- type group id name, can be any name
    --     displayName = "General", -- Display Name
    --     icon = "#globe-europe", -- Icon, should be with `#` cuz from HTML and check HTML for edits
    --     enableMenu = function()
    --         return not isDead -- if person is dead or in vehicle. we don't want dead people to see this button if dead
    --     end,
    --     subMenus = {"general:escort", "general:emotes", "general:putinvehicle", "general:unseatnearest"} -- add submenu names that will be shown after clicking General button
    -- }

    -- NOTE
    -- EXAMPLE:
    -- {
    --     id = "copDead",
    --     displayName = "11-A",
    --     icon = "#police-dead",
    --     enableMenu = function()
    --         return isPolice and isDead and onDuty -- here button checks if person is cop and dead and on duty. if 3 of them true then this will be shown
    --     end,
    --     subMenus = {"general:escort", "general:emotes", "general:putinvehicle", "general:unseatnearest"}
    -- }
}

newSubMenus = { -- NOTE basicly, what will be happen after clicking these buttons and icon of them
    ['general:givenum'] = {
        title = "Give contact",
        icon = "#contact-share",
        functionName = "qb-phone:client:GiveContactDetails" -- must be client event, work same as TriggerEvent('emotes:OpenMenu')
    }, 
    ["expressions:angry"] = {
        title="Angry",
        icon="#expressions-angry",
        functionName = "exter:exp1",
    },
    ["expressions:drunk"] = {
        title="Drunk",
        icon="#expressions-drunk",
        functionName = "exter:exp2",
    },
    ["expressions:dumb"] = {
        title="Dumb",
        icon="#expressions-dumb",
        functionName = "exter:exp3",
    },
    ["expressions:electrocuted"] = {
        title="Electrocuted",
        icon="#expressions-electrocuted",
        functionName = "exter:exp4",
    },
    ["expressions:grumpy"] = {
        title="Grumpy",
        icon="#expressions-grumpy",
        functionName = "exter:exp5",
    },
    ["expressions:happy"] = {
        title="Happy",
        icon="#expressions-happy",
        functionName = "exter:exp8",
    },
    ["expressions:injured"] = {
        title="Injured",
        icon="#expressions-injured",
        functionName = "exter:exp9",
    },
    ["expressions:joyful"] = {
        title="Joyful",
        icon="#expressions-joyful",
        functionName = "exter:exp10",
    },
    ["expressions:mouthbreather"] = {
        title="Mouth Breather",
        icon="#expressions-mouthbreather",
        functionName = "exter:exp11",
    },
    ["expressions:shocked"]  = {
        title="Shocked",
        icon="#expressions-shocked",
        functionName = "exter:exp12",
    },
    ["expressions:sleeping"]  = {
        title="Sleeping",
        icon="#expressions-sleeping",
        functionName = "exter:exp13",
    },
    ["expressions:smug"]  = {
        title="smug",
        icon="#expressions-smug",
        functionName = "exter:exp14",
    },
    ["expressions:speculative"]  = {
        title="Speculative",
        icon="#expressions-speculative",
        functionName = "exter:exp15",
    },
    ["expressions:stressed"]  = {
        title="Stressed",
        icon="#expressions-stressed",
        functionName = "exter:exp16",
    },
    ["expressions:sulking"]  = {
        title="Sulking",
        icon="#expressions-sulking",
        functionName = "exter:exp17",
    },
    ["expressions:weird"]  = {
        title="Weird",
        icon="#expressions-weird",
        functionName = "exter:exp18",
    },
    ["expressions:weird2"]  = {
        title="Weird2",
        icon="#expressions-weird2",
        functionName = "exter:exp19",
    },
    ['blips:gasstations'] = {
        title = "Gas Station",
        icon = "#blips-gasstations",
        functionName = "ygx:togglegas"
    },
   --[[ ['blips:trainstations'] = {
        title = "Tren istasyonları",
        icon = "#blips-trainstations",
        functionName = "Trains:ToggleTainsBlip"
    },--]]
    ['blips:garages'] = {
        title = "Garages",
        icon = "#blips-garages",
        functionName = "Garages:ToggleGarageBlip"
    },
    ['blips:barbershop'] = {
        title = "Barber",
        icon = "#blips-barbershop",
        functionName = "ygx:togglebarber"
    },
    ['fk:galeri'] = {
        title = "PDM",
        icon = "#blips-garages",
        functionName = "fk:galeri"
    },
    ['animations:brave'] = {
        title = "Brave",
        icon = "#animation-brave",
        functionName = "AnimSet:Brave"
    },
    ['animations:hurry'] = {
        title = "Hurry",
        icon = "#animation-swagger",
        functionName = "AnimSet:Hurry"
    },
    ['animations:business'] = {
        title = "Business",
        icon = "#animation-business",
        functionName = "AnimSet:Business"
    },
    ['animations:tipsy'] = {
        title = "Tipsy",
        icon = "#animation-tipsy",
        functionName = "AnimSet:Tipsy"
    },
    ['animations:injured'] = {
        title = "Injured",
        icon = "#animation-injured",
        functionName = "AnimSet:Injured"
    },
    ['animations:tough'] = {
        title = "Tough",
        icon = "#animation-tough",
        functionName = "AnimSet:ToughGuy"
    },	
    ['animations:sassy'] = {
        title = "Sassy",
        icon = "#animation-sassy",
        functionName = "AnimSet:Sassy"
    },
    ['animations:sad'] = {
        title = "Sad",
        icon = "#animation-sad",
        functionName = "AnimSet:Sad"
    },
    ['animations:posh'] = {
        title = "Posh",
        icon = "#animation-posh",
        functionName = "AnimSet:Posh"
    },
    ['animations:alien'] = {
        title = "Alien",
        icon = "#animation-alien",
        functionName = "AnimSet:Alien"
    },
    ['animations:hobo'] = {
        title = "Hobo",
        icon = "#animation-hobo",
        functionName = "AnimSet:Hobo"
    },
    ['animations:money'] = {
        title = "Money",
        icon = "#animation-money",
        functionName = "AnimSet:Money"
    },
    ['animations:swagger'] = {
        title = "Swag",
        icon = "#animation-swagger",
        functionName = "AnimSet:Swagger"
    },
    ['animations:shady'] = {
        title = "Gangster",
        icon = "#animation-shady",
        functionName = "AnimSet:Shady"
    },
    ['animations:maneater'] = {
        title = "Sassy3",
        icon = "#animation-sassy",
        functionName = "AnimSet:ManEater"
    },
    ['animations:chichi'] = {
        title = "Sassy2",
        icon = "#animation-sassy",
        functionName = "AnimSet:ChiChi"
    },
    ['animations:default'] = {
        title = "Normal",
        icon = "#animation-default",
        functionName = "AnimSet:default"
    },
    ['general:rob'] = {
        title = "Rob",
        icon = "#steal",
        functionName = "police:client:RobPlayer" -- must be client event, work same as TriggerEvent('emotes:OpenMenu')
    },
    ['general:playerinvehicle'] = {
        title = "Seat Vehicle",
        icon = "#general-put-in-veh",
        functionName = "police:client:PutPlayerInVehicle" -- must be client event, work same as TriggerEvent('emotes:OpenMenu')
    },
    ['general:playeroutvehicle'] = {
        title = "Unseat Vehicle",
        icon = "#general-put-in-veh",
        functionName = "police:client:SetPlayerOutVehicle" -- must be client event, work same as TriggerEvent('emotes:OpenMenu')
    }, 
    ['drug:sell'] = {
        title = "Cornersell",
        icon = "#ped-sell-stolen-items",
        functionName = "qb-drugs:client:cornerselling"
    },
    ['general:cuff'] = {
        title = "Cuff",
        icon = "#cuffs-cuff",
        functionName = "police:client:CuffPlayer"
    },
    -- POLICE 
    ['police:statuscheck'] = {
        title = "Status Check",
        icon = "#cocaine-status",
        functionName = "hospital:client:CheckStatus"
    },
    ['police:searchplayer'] = {
        title = "Search player",
        icon = "#police-action-frisk",
        functionName = "police:client:SearchPlayer"
    },
    ['police:jail'] = {
        title = "Jail Player",
        icon = "#heroin-lock-door",
        functionName = "police:client:JailPlayer"
    },
    ['police:seizecash'] = {
        title = "Seize Cash",
        icon = "#dollar-new",
        functionName = "police:client:SeizeCash"
    },
    ['police:bill'] = {
        title = "Bill",
        icon = "#general-cuff",
        functionName = "police:client:BillPlayer"
    },  
    ['police:mdt'] = {
        title = "MDT",
        icon = "#mdt",
        functionName = "mdt:client:OpenMDT"    
    },
    ['police:takeoffmask'] = {
        title = "Mask",
        icon = "#cuffs-remove-mask",
        functionName = "police:client:takeoffmask" 
    },
    -- ['police:checkvehicle'] = {
    --     title = "Check Vehicle Status",
    --     icon = "#police-chechvehiclestatus",
    --     functionName = "qb-tunerchip:server:TuneStatus"     
    -- },  
    ['police:takedriverlicense'] = {
        title = "Revoke Drivers License",
        icon = "#driver-license",
        functionName = "police:client:SeizeDriverLicense"     
    },  
    -- POLICE
    ['police:spawn1'] = {
        title = "Cone",
        icon = "#police-revokelicense",
        functionName = "police:client:spawnCone"     
    },   
['police:spawn2'] = {
    title = "Spikes",
    icon = "#police-revokelicense",
    functionName = "police:client:SpawnSpikeStrip" 
},
    ['police:del'] = {
        title = "Delete",
        icon = "#police-revokelicense",
        functionName = "police:client:deleteObjectw"     
    },
    -- HOSPITAL
    ['medic:status'] = {
        title = "StatusCheck",
        icon = "#general-cuff",
        functionName = "" 
    },
    ['medic:revive'] = {
        title = "Revive",
        icon = "#hospital-revivep",
        functionName = "hospital:client:RevivePlayer"
    },
    ['medic:treat'] = {
        title = "Heal wounds",
        icon = "#hospital-treat",
        functionName = "hospital:client:TreatWounds"
    },
    ['medic:stretcherspawn'] = {
        title = "Stretcher",
        icon = "#general-cuff",
        functionName = "hospital:client:TakeStretcher" 
    }, 
    ['medic:stretcherremove'] = {
        title = "Stretcher Remove",
        icon = "#general-cuff",
        functionName = "hospital:client:RemoveStretcher" 
    },  --TOW --TOW
    ['tow:togglenpc'] = {
        title = "Toggle Npc",
        icon = "#tow-mission",
        functionName = "jobs:client:ToggleNpc"
    }, 
    ['tow:vehicle'] = {
        title = "Tow vehicle",
        icon = "#tow-tow",
        functionName = "qb-tow:client:TowVehicle"
    },  -- Taxi
    ['taxi-meter'] = {
        title = "Toggle Npc",
        icon = "#tow-mission",
        functionName = "qb-taxi:client:toggleMeter"
    }, 
    ['taxi:npc'] = {
        title = "Taxi mission",
        icon = "#tow-tow",
        functionName = "qb-taxi:client:DoTaxiNpc"
    },  
    ['taxi:startmeter'] = {
        title = "Start/Stop meter",
        icon = "#tow-tow",
        functionName = "qb-taxi:client:enableMeter"
    },
    -- ['k9:spawn'] = {
    --     title = "Summon",
    --     icon = "#k9-spawn",
    --     functionName = "K9:Create"
    -- },
    -- ['k9:delete'] = {
    --     title = "Dismiss",
    --     icon = "#k9-dismiss",
    --     functionName = "K9:Delete"
    -- },
    ['k9:follow'] = {
        title = "Follow",
        icon = "#k9-follow",
        functionName = "qb-k9:Follow"
    },
    ['k9:vehicle'] = {
        title = "Get In/Out",
        icon = "#k9-vehicle",
        functionName = "qb-k9:EnterVeh"
    },
    ['k9:sit'] = {
        title = "Sit",
        icon = "#k9-sit",
        functionName = "qb-k9:Sit"
    },
    ['k9:lay'] = {
        title = "Lay",
        icon = "#k9-lay",
        functionName = "qb-k9:laydown"
    },
    ['k9:stand'] = {
        title = "Stand",
        icon = "#k9-stand",
        functionName = "qb-k9:Follow"
    },
    ['k9:sniff'] = {
        title = "Sniff Person",
        icon = "#k9-sniff",
        functionName = "qb-k9:searchdude"
    },
    ['k9:sniffvehicle'] = {
        title = "Sniff Vehicle",
        icon = "#k9-sniff-vehicle",
        functionName = "qb-k9:searchcar"
    },
    ['k9:huntfind'] = {
        title = "Search Area",
        icon = "#k9-huntfind",
        functionName = "qb-k9:searcharea"
    },
}
    

RegisterNetEvent("isJudge") -- these are all up to you and your job system, if person become Judge, script will see him as Judge too.
AddEventHandler("isJudge", function()
    isJudge = true
end)

RegisterNetEvent("isJudgeOff") -- opposite of the above
AddEventHandler("isJudgeOff", function()
    isJudge = false
end)

RegisterNetEvent("isTow") -- these are all up to you and your job system, if person become Judge, script will see him as Judge too.
AddEventHandler("isTow", function()
    isTow = true
end)

RegisterNetEvent("isTowOff") -- these are all up to you and your job system, if person become Judge, script will see him as Judge too.
AddEventHandler("isTowOff", function()
    isTow = false
end)

RegisterNetEvent("isTaxi") -- these are all up to you and your job system, if person become Judge, script will see him as Judge too.
AddEventHandler("isTaxi", function()
    isTaxi = true
end)

RegisterNetEvent("isTaxiOff") -- opposite of the above
AddEventHandler("isTaxiOff", function()
    isTaxi = false
end)

RegisterNetEvent("QBCore:Client:OnJobUpdate") -- dont edit this unless you don't use qb-core
AddEventHandler("QBCore:Client:OnJobUpdate", function(jobInfo)
    myJob = jobInfo.name
    if isMedic and myJob ~= "ambulance" then isMedic = false end
    if isPolice and myJob ~= "police" then isPolice = false end
    if isTow and myJob ~= "tow" then isTow = false end
    if isTaxi and myJob ~= "taxi" then isTaxi = false end
    if myJob == "police" then isPolice = true end
    if myJob == "tow" then isTow = true end
    if myJob == "taxi" then isTaxi = true end
    if myJob == "ambulance" then isMedic = true end
end)

RegisterNetEvent('QBCore:Client:SetDuty') -- dont edit this unless you don't use qb-core
AddEventHandler('QBCore:Client:SetDuty', function(duty)
    myJob = QBCore.Functions.GetPlayerData().job.name
    if isMedic and myJob ~= "ambulance" then isMedic = false end
    if isPolice and myJob ~= "police" then isPolice = false end
    if myJob == "police" then isPolice = true onDuty = duty end
    if myJob == "ambulance" then isMedic = true onDuty = duty end
end)

RegisterNetEvent('deathcheck') -- YOU SHOULD ADD THIS IN YOUR ambulancejob system, basically let the function trigger here when the ped playing anim and add this to
-- your revived function so everytime if person dies, this will be triggered to isDead = true, if he get revived this will be triggered to isDead = false
AddEventHandler('deathcheck', function()
    if not isDead then
        isDead = true
    else
        isDead = false
    end
end)


RegisterNetEvent("police:currentHandCuffedState") -- add this your police:client:GetCuffed @qb-policejob\client\interactions.lua
AddEventHandler("police:currentHandCuffedState", function(pIsHandcuffed)
    isHandcuffed = pIsHandcuffed
end)

RegisterNetEvent("menu:hasOxygenTank") -- add this to your oxygentank wear place, idk where is this for qb-inventory so find out please
AddEventHandler("menu:hasOxygenTank", function(pHasOxygenTank)
    hasOxygenTankOn = pHasOxygenTank
end)


RegisterNetEvent('police:client:PutInVehicle')
AddEventHandler('police:client:PutInVehicle', function()
    if isEscorted then
    end
end)
