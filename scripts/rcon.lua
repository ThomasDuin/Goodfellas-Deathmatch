local rconPassword = "test"
local admins = {}

local function cmd_loadScript(playerid, text)
	if(admins[playerid] ~= nil) then
		--Already authed as admin here
		if(string.sub(text, 1, 11) == "/loadscript") then
			local scriptName = string.sub(text, 13)
			print("RCON: Loading FS: " .. scriptName)
			if(isScriptLoaded(scriptName)) then
				unloadScript(scriptName)
				sendPlayerMsg(playerid, scriptName .. " was unloaded", 0xFFFFFFFF)
			end
			if(loadScript(scriptName)) then
				sendPlayerMsg(playerid, scriptName .. " was loaded", 0xFFFFFFFF)
			end
		end
	end
end

local function cmd_rconLogin(playerid, text)
	local pw = string.sub(text, 12)
	print(getPlayerName(playerid) .. " attempted to rconlogin with pw: " .. pw)
	if(pw == rconPassword) then
		admins[playerid] = true
		sendPlayerMsg(playerid, "Admin status activated", 0xFFFF0000)
	end
end

local function cmd_rconKick(playerid, text)
	local target = string.sub(text, 6)
	if(target == nil or isPlayerOnline(target) ~= true) then
		return sendPlayerMsg(playerid, "Invalid player ID", 0xFFFF0000)
	end
	sendPlayerMsg(playerid, "You kicked " .. getPlayerName(target) .. " out the server")
	kickPlayer(target)
end

function rconCommandEvent(playerid, text)
	if(string.sub(text, 1, 11) == "/loadscript") then
			cmd_loadScript(playerid, text)
	elseif(string.sub(text, 1, 10) == "/rconlogin") then
		cmd_rconLogin(playerid, text)
	elseif(string.sub(text, 1, 5) == "/kick") then
		cmd_rconKick(playerid, text)
	end	
end
registerEvent("rconCommandEvent", "onPlayerCommand")

function rconPlayerLeft(playerid, reason)
	if(admins[playerid] ~= nil) then
		--Player was authed as admin, now we remove his status
		admins[playerid] = nil
		print(getPlayerName(playerid) .. " rcon was freed")
	end
end
registerEvent("rconPlayerLeft", "onPlayerLeft")