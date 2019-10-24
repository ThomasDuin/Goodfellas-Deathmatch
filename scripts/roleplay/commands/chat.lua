local function talkCommand(playerid, commands)
    if commands[2] and commands[2] ~= "" then
        local x, y, z = getPlayerPos(playerid)
        local players = getPlayers()
        for i, id in ipairs(players) do
            local xP, yP, zP = getPlayerPos(id)
            local distance = getDistanceBetweenVectors(x, y, z, xP, yP, zP)

            if Globals.constants.distanceChat > distance then
                sendPlayerMsg(id, getPlayerName(playerid) .. "(" .. playerid .. ") says: " .. stringifyArrayFrom(2, commands), 0xFFFFFFFF)
            else 
                print("not close enough")
            end
        end
    else 
        sendPlayerMsg(playerid, "Usage: /l text", 0xFFFFFFFF)
    end
end
table.insert(Globals.commands.chat, Commands:create("/l", talkCommand))

local function shoutCommand(playerid, commands)
    if commands[2] and commands[2] ~= "" then
        local x, y, z = getPlayerPos(playerid)
        local players = getPlayers()
        for i, id in ipairs(players) do
            local xP, yP, zP = getPlayerPos(id)
            local distance = getDistanceBetweenVectors(x, y, z, xP, yP, zP)

            if Globals.constants.distanceShout > distance then
                sendPlayerMsg(id, getPlayerName(playerid) .. "(" .. playerid .. ") shouted: " .. stringifyArrayFrom(2, commands), 0xFFFFFFFF)
            else 
                print("not close enough")
            end
        end
    else 
        sendPlayerMsg(playerid, "Usage: /s text", 0xFFFFFFFF)
    end
end
table.insert(Globals.commands.chat, Commands:create("/s", shoutCommand))

local function meCommand(playerid, commands)
    if commands[2] and commands[2] ~= "" then
        local x, y, z = getPlayerPos(playerid)
        local players = getPlayers()
        for i, id in ipairs(players) do
            local xP, yP, zP = getPlayerPos(id)
            local distance = getDistanceBetweenVectors(x, y, z, xP, yP, zP)

            if Globals.constants.distanceShout > distance then
                sendPlayerMsg(id, getPlayerName(playerid) .. "(" .. playerid .. ") " .. stringifyArrayFrom(2, commands), 0xFFFFFFFF)
            else 
                print("not close enough")
            end
        end
    else 
        sendPlayerMsg(playerid, "Usage: /me text", 0xFFFFFFFF)
    end
end
table.insert(Globals.commands.chat, Commands:create("/me", meCommand))

local function whisperCommand(playerid, commands)
    if commands[2] and commands[2] ~= "" then
        local x, y, z = getPlayerPos(playerid)
        local players = getPlayers()
        for i, id in ipairs(players) do
            local xP, yP, zP = getPlayerPos(id)
            local distance = getDistanceBetweenVectors(x, y, z, xP, yP, zP)

            if Globals.constants.distanceWhisper > distance then
                sendPlayerMsg(id, getPlayerName(playerid) .. "(" .. playerid .. ") whispered: " .. stringifyArrayFrom(2, commands), 0xFFFFFFFF)
            else 
                print("not close enough")
            end
        end
    else 
        sendPlayerMsg(playerid, "Usage: /w text", 0xFFFFFFFF)
    end
end
table.insert(Globals.commands.chat, Commands:create("/w", whisperCommand))

local function emCommand(playerid, commands)
    if commands[2] and commands[2] ~= "" then
        local x, y, z = getPlayerPos(playerid)
        local players = getPlayers()
        for i, id in ipairs(players) do
            local xP, yP, zP = getPlayerPos(id)
            local distance = getDistanceBetweenVectors(x, y, z, xP, yP, zP)
            print(distance)
            if Globals.constants.distanceShout > distance then
                sendPlayerMsg(id, commands[2] .. " " .. getPlayerName(playerid) .. " (" .. playerid .. ")", 0xFFFFFFFF)
            else 
                print("not close enough")
            end
        end
    else 
        sendPlayerMsg(playerid, "Usage: /em text", 0xFFFFFFFF)
    end
end
table.insert(Globals.commands.chat, Commands:create("/em", emCommand))

local function pmCommand(playerid, commands)
    if commands[2] and commands[2] ~= "" and commands[3] and commands[3] ~= "" then
        local toSendTo = tonumber(commands[2])
        if isPlayerOnline(toSendTo) then
            sendPlayerMsg(toSendTo, getPlayerName(playerid) .. "(" .. playerid .. ") messages you: " .. stringifyArrayFrom(3, commands), 0xFFFFFFFF)
            sendPlayerMsg(playerid, "You messaged " .. getPlayerName(playerid) .. "(" .. playerid .. ") messages you: " .. stringifyArrayFrom(3, commands), 0xFFFFFFFF)
        else
            sendPlayerMsg(playerid, "That player is nowhere to be seen", 0xFFFFFFFF)
        end
    else 
        sendPlayerMsg(playerid, "Usage: /pm id text", 0xFFFFFFFF)
    end
end
table.insert(Globals.commands.chat, Commands:create("/pm", pmCommand))