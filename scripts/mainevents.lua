spawns = {
    { x = -608.03790283203, y = -771.40985107422, z = 19.698240280151, h = 178.03800964355 },
    { x = -589.40698242188, y = -773.56976318359, z = 15.987970352173, h = 182.70085144043 },
    { x = -626.73944091797, y = -773.58465576172, z = 15.938999176025, h = 176.7412109375 },
    { x = -607.99029541016, y = -792.58465576172, z = 12.071273803711, h = 359.58978271484 },
    { x = -608.10968017578, y = -768.46118164063, z = 8.8789281845093, h = 177.12788391113 },
    { x = -603.76531982422, y = -788.12841796875, z = 3.8440771102905, h = 91.184608459473 },
    { x = -612.34967041016, y = -788.10235595703, z = 3.8440771102905, h = 265.59341430664 },
    { x = -593.87414550781, y = -818.69305419922, z = 3.8428587913513, h = 334.88391113281 },
    { x = -629.26538085938, y = -813.57214355469, z = 3.8431262969971, h = 47.032222747803 },
    { x = -631.56597900391, y = -915.97009277344, z = 3.8428559303284, h = 338.84744262695 },
    { x = -589.26458740234, y = -916.50085449219, z = 3.8428568840027, h = 14.37964630127 },
    { x = -610.71148681641, y = -949.84075927734, z = 3.8428559303284, h = 356.28030395508 }
}

resetPlayerLocation = { x = -608.04040527344, y = -866.38244628906, z = 3.8428568840027, h = 1.5157932043076 }

suicideMessages = {
    "managed whack himself in the head",
    "couldn't call an ambulance before he died",
    "couldn't take it anymore and killed himself",
    "dreamed of being better and his heart stopped",
    "walked into a lamppost and died",
    "had a change of heart and decided to die",
    "stop killing yourself",
    "stumbled and fell"
}

math.randomseed(os.time())
print(math.random(1, #spawns))

skinLimit = 345 -- higher are eflc skins

local id = createCheckPoint(-608.04040527344, -866.38244628906, -2, 500, 0xFF000000, 1, 0, 1)
setEntityStreamDistance(2, id, 501.0)

function drawGui() end

function playerSpawnCredentials(playerid)
    checkPlayerHacks(playerid)

    Globals.accounts[playerid] = Account:create(nil)
    Globals.accounts[playerid].playerid = playerid
    Globals.accounts[playerid].commands.misc = Globals.commands.misc

    -- set player stuff
    print("Player " .. getPlayerName(playerid) .. "(" .. playerid .. ") credentials arrived")
    sendMsgToAll("Are you guys ready? " .. getPlayerName(playerid) .. " has joined the server", 0xFFFF0000)
    sendPlayerMsg(playerid, "Welcome to Goodfellas deathmatch server", 0xFFFFFFFF)
    sendPlayerMsg(playerid, "This mode works as follows...", 0xFFFFFFFF)
    sendPlayerMsg(playerid, "With every 5 kills, you gain a new weapon", 0xFFFFFFFF)

    local randomSpawn = spawns[math.random(1, #spawns)]
	spawnPlayer(playerid, randomSpawn.x, randomSpawn.y, randomSpawn.z)
    setPlayerHeading(playerid, randomSpawn.h)
    setPlayerSkin(playerid, math.random(1, skinLimit))

    -- Timer because somehow you don't get a weapon instantly after setting
    setTimer("giveWeaponTimer", 5000, 1, playerid)

    Globals.accounts[playerid]:drawGui()

end
registerEvent("playerSpawnCredentials", "onPlayerCredential")

function giveWeaponTimer(playerid)
    givePlayerWeapon(playerid, 7, 999)
    print("gave weapon timer " .. playerid)
end

function playerCommand(playerid, text)
	local commands = split(text, " ")

    for key, value in pairs(Globals.accounts[playerid].commands) do
        for i = 1, #value do  
            local command = value[i]
            if command.name == commands[1] then
                command.execute(playerid, commands)
                return;
            end
        end
    end

    sendPlayerMsg(playerid, "Unknown cmd, what are you trying to do?", 0xFFFFFFFF)
end
registerEvent("playerCommand", "onPlayerCommand")

function playerLeft(playerid, reason)
    print("Player " .. getPlayerName(playerid) .. "(" .. playerid .. ") left")

    for k,v in pairs(Globals.accounts[playerid].commands) do Globals.accounts[playerid].commands[k]=nil end
    for k,v in pairs(Globals.accounts[playerid]) do Globals.accounts[playerid][k]=nil end
    Globals.accounts[playerid] = nil
end
registerEvent("playerLeft", "onPlayerLeft")

function myPlayerDeath(playerid, lastDamageType, lastDamageGiver)
    print("Player " .. getPlayerName(playerid) .. "(" .. playerid .. ") died")
    print("lastDamageType: " .. lastDamageType)    

    Globals.accounts[playerid]:stopSpree()
    if(lastDamageType == 0) then
        if(isPlayerOnline(lastDamageGiver)) then
            print(getPlayerName(lastDamageGiver) .. " killed " .. getPlayerName(playerid))      
            sendMsgToAll(getPlayerName(lastDamageGiver) .. " killed " .. getPlayerName(playerid), 0xFFFF0000)

            -- handle playerkills
            Globals.accounts[lastDamageGiver]:increaseKills()

            print("lasthitBone: .. " .. Globals.accounts[playerid].lastHitBone)
            if Globals.accounts[playerid].lastHitBone == 13985 then 
                Globals.accounts[lastDamageGiver]:playSound("headshot")
            end

            if Globals.accounts[lastDamageGiver].kills == 1 then
                Globals.accounts[lastDamageGiver]:playSound("firstblood")
            end

            Globals.accounts[playerid].lastKilledBy = lastDamageGiver

            if Globals.accounts[lastDamageGiver].lastKilledBy == playerid then
                Globals.accounts[lastDamageGiver]:playSound("vengeance")
            end

            Globals.accounts[playerid]:doSpreeSounds()
        else
            --The player is no longer online
        end
    elseif lastDamageType == 1 then
        Globals.accounts[lastDamageGiver]:playSound("vehicularmanslaughter")
    else
        Globals.accounts[playerid]:playSound("humiliation")
        sendMsgToAll(getPlayerName(playerid) .. " " .. suicideMessages[math.random(1, #suicideMessages)], 0xFFFF0000)
    end
end
registerEvent("myPlayerDeath", "onPlayerDeath")

function stopStreamTimer(playerid)
    stopPlayerStreams(playerid)
    print("stopping stream for " .. playerid)
end

function myPlayerSpawn(playerid)
    print("Player " .. getPlayerName(playerid) .. "(" .. playerid .. ") respawned")

    local randomSpawn = spawns[math.random(1, #spawns)]
	spawnPlayer(playerid, randomSpawn.x, randomSpawn.y, randomSpawn.z)
    setPlayerHeading(playerid, randomSpawn.h)
    setPlayerSkin(playerid, math.random(1, skinLimit))

    Globals.accounts[playerid]:giveWeaponsAccordingly()
end
registerEvent("myPlayerSpawn", "onPlayerSpawn")

function onPlayerExitCheckPoint(playerid, checkpointId)
    print(playerid .. " tried to exit the checkpoint")
    sendPlayerMsg(playerid, "Stay on the island!!!", 0xFFFF0000)
    setPlayerPos(playerid, resetPlayerLocation.x, resetPlayerLocation.y, resetPlayerLocation.z)
    setPlayerHeading(playerid, resetPlayerLocation.h)
end
registerEvent("onPlayerExitCheckPoint", "onPlayerExitCheckPoint")

function onPlayerEnterCheckPoint(playerid, checkpointId)
    print(playerid .. " entered the checkpoint")
end
registerEvent("onPlayerEnterCheckPoint", "onPlayerEnterCheckPoint")

function onPlayerHpChange(playerid, agentType, agentId, boneId)
    Globals.accounts[playerid].lastHitBone = boneId
end
registerEvent("onPlayerHpChange", "onPlayerHpChange")

