local function danceCommands(playerid, commands)
    if commands[1] and commands[2] and commands[3] then
        if commands[2] == "f" then 
            if commands[3] == "1" then forcePlayerAnim(playerid, "amb@dance_femidl_a", "loop_a", true)
            elseif commands[3] == "2" then forcePlayerAnim(playerid, "amb@dance_femidl_b", "loop_b", true) 
            elseif commands[3] == "3" then forcePlayerAnim(playerid, "amb@dance_femidl_c", "loop_c", true) end
        end

        if commands[2] == "m" then
            if commands[3] == "1" then forcePlayerAnim(playerid, "amb@dance_maleidl_a", "loop_a", true)
            elseif commands[3] == "2" then forcePlayerAnim(playerid, "amb@dance_maleidl_b", "loop_b", true) 
            elseif commands[3] == "3" then forcePlayerAnim(playerid, "amb@dance_maleidl_c", "loop_c", true) 
            elseif commands[3] == "4" then forcePlayerAnim(playerid, "amb@dance_maleidl_d", "loop_d", true) end
        end

        sendPlayerMsg(playerid, "Use /stopanim to quit dancing.", 0xFFFFFFFF)
    else
        sendPlayerMsg(playerid, "Usage: /dance f/m number", 0xFFFFFFFF)
    end
end
table.insert(Globals.commands.misc, Commands:create("/dance", danceCommands))

local function stopAnimCommand(playerid, commands)
    stopPlayerAnims(playerid)
end
table.insert(Globals.commands.misc, Commands:create("/stopanim", stopAnimCommand))

local function getPositionCommand(playerid, commands)
    local x, y, z = getPlayerPos(playerid)
    local h = getPlayerHeading(playerid)
    sendPlayerMsg(playerid, "x: " .. x, 0xFFFFFFFF)
    sendPlayerMsg(playerid, "y: " .. y, 0xFFFFFFFF)
    sendPlayerMsg(playerid, "z: " .. z, 0xFFFFFFFF)
    sendPlayerMsg(playerid, "h: " .. h, 0xFFFFFFFF)
    
    print(x .. " " .. y .. " " .. z .. " " .. h)
end
table.insert(Globals.commands.misc, Commands:create("/getpos", getPositionCommand))

local function setSkinCommand(playerid, commands)
    if commands[2] then
        setPlayerSkin(playerid, tonumber(commands[2]))
    end
end
table.insert(Globals.commands.misc, Commands:create("/skin", setSkinCommand))

-- local function setWeatherCommand(playerid, commands)
--     if commands[2] then
--         setWorldWeather(1, tonumber(commands[2]))
--     end
-- end
-- table.insert(Globals.commands.misc, Commands:create("/setweather", setWeatherCommand))

-- local function setTimeCommand(playerid, commands)
--     if commands[2] then
--         setWorldTime(1, tonumber(commands[2]), 0)
--     end
-- end
-- table.insert(Globals.commands.misc, Commands:create("/settime", setTimeCommand))

-- local function setWeaponCommand(playerid, commands)
--     if commands[2] then
--         givePlayerWeapon(playerid, tonumber(commands[2]), 600)
--     end
-- end
-- table.insert(Globals.commands.misc, Commands:create("/setweapon", setWeaponCommand))

-- -- spawning car
-- local spawnedCars = {}

-- local function deletePlayerVehicles(playerid)
-- 	if(spawnedCars[playerid] ~= nil) then
-- 		local carId = spawnedCars[playerid]
-- 		if(isVehicle(carId)) then
-- 			deleteVehicle(carId)
-- 		end
-- 	end 
-- end

-- function carSpawningCommandEvent(playerid, text)
-- 	if(string.sub(text, 1, 2) == "/v") then
-- 		local modelName = string.upper(string.sub(text, 4))
-- 		local modelId = getVehicleModelId(modelName)
-- 		if(modelId == -1) then
-- 			sendPlayerMsg(playerid, "'" .. modelName .. "' is an invalid vehicle name", 0xFFFF0000)
-- 			return
-- 		end
-- 		local x, y, z = getPlayerPos(playerid)
-- 		local rColor = math.random(0, 170)
-- 		deletePlayerVehicles(playerid)
-- 		local carId = createVehicle(modelId, x, y, z, 0.0, 0.0, 0.0, rColor, rColor, rColor, rColor, getPlayerWorld(playerid))
-- 		spawnedCars[playerid] = carId
-- 		sendPlayerMsg(playerid, modelName .. " spawned with id " .. carId .. " with color " .. rColor, 0xFFFFFFFF)			
-- 	end
-- end
-- registerEvent("carSpawningCommandEvent", "onPlayerCommand")

-- function carSpawningPlayerLeft(playerid, reason)
-- 	if(spawnedCars[playerid] ~= nil and isVehicle(spawnedCars[playerid])) then
-- 		deleteVehicle(spawnedCars[playerid])
-- 		spawnedCars[playerid] = nil
-- 	end
-- end
-- registerEvent("carSpawningPlayerLeft", "onPlayerLeft")

local function suicideCommand(playerid, commands)
    setPlayerHealth(playerid, -1)
end
table.insert(Globals.commands.misc, Commands:create("/kill", suicideCommand))

local function getPlayerAnimCommand(playerid, commands)
    print(getPlayerAnim(playerid))
end
table.insert(Globals.commands.misc, Commands:create("/getanim", getPlayerAnimCommand))