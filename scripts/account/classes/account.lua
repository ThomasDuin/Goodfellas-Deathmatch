Account = {    
    commands = {},

    playerid = nil,

    kills = 0,
    spree = 0,

    lastHitBone = nil,
    lastKilledBy = nil
}

function Account:create(o)
    local o = o or {}

    setmetatable(o, self)
    self.__index = self

    return o
end

function Account:increaseKills()
    print("increase kills")
    self.kills = self.kills + 1
    self.spree = self.spree + 1
    print(self.kills)
    print(self.spree)

    self:drawGui()
end

function Account:stopSpree()
    self.spree = 0

    self:drawGui()
end

function Account:giveWeaponsAccordingly()
    givePlayerWeapon(self.playerid, 7, 999)
    if self.kills > 0 then
        local every5kills = self.kills / 5

        if every5kills >= 1 then givePlayerWeapon(self.playerid, 9, 999) end
        if every5kills >= 2 then givePlayerWeapon(self.playerid, 10, 999) end
        if every5kills >= 3 then givePlayerWeapon(self.playerid, 11, 999) end
        if every5kills >= 4 then givePlayerWeapon(self.playerid, 12, 999) end
        if every5kills >= 5 then givePlayerWeapon(self.playerid, 13, 999) end
        if every5kills >= 6 then givePlayerWeapon(self.playerid, 14, 999) end
        if every5kills >= 7 then givePlayerWeapon(self.playerid, 15, 999) end
        if every5kills >= 8 then givePlayerWeapon(self.playerid, 16, 999) end
        if every5kills >= 9 then givePlayerWeapon(self.playerid, 17, 999) end
    end
end

function Account:doSpreeSounds()
    if self.spree >= 5 then
        local every5kills = self.spree / 5

        if every5kills == 5 then self:playSound("killingspree")
        elseif every5kills == 10 then self:playSound("rampage")
        elseif every5kills == 15 then self:playSound("dominating")
        elseif every5kills == 20 then self:playSound("unstoppable")
        elseif every5kills == 25 then self:playSound("godlike")
        elseif every5kills == 30 then self:playSound("extermination")
        elseif every5kills % 5 == 0 then self:playSound("extermination") end
    end
end

function Account:playSound(sound) 
    local playerid = self.playerid
    if sound == "humiliation" then
        playStreamFrontend(playerid, "http://136.144.207.116/soundeffects/humiliation.mp3")
        setTimer("stopStreamTimer", 2000, 1, playerid)
    elseif sound == "firstblood" then
        playStreamFrontend(playerid, "http://136.144.207.116/soundeffects/firstblood.mp3")
        setTimer("stopStreamTimer", 3000, 1, playerid)
    elseif sound == "rampage" then
        playStreamFrontend(playerid, "http://136.144.207.116/soundeffects/rampage.mp3")
        setTimer("stopStreamTimer", 3000, 1, playerid)
    elseif sound == "dominating" then
        playStreamFrontend(playerid, "http://136.144.207.116/soundeffects/dominating.mp3")
        setTimer("stopStreamTimer", 2000, 1, playerid)
    elseif sound == "godlike" then
        playStreamFrontend(playerid, "http://136.144.207.116/soundeffects/godlike.mp3")
        setTimer("stopStreamTimer", 2000, 1, playerid)
    elseif sound == "vengeance" then
        playStreamFrontend(playerid, "http://136.144.207.116/soundeffects/vengeance.mp3")
        setTimer("stopStreamTimer", 2000, 1, playerid)
    elseif sound == "vehicularmanslaughter" then
        playStreamFrontend(playerid, "http://136.144.207.116/soundeffects/vehicularmanslaughter.mp3")
        setTimer("stopStreamTimer", 4000, 1, playerid)
    elseif sound == "killingspree" then
        playStreamFrontend(playerid, "http://136.144.207.116/soundeffects/killingspree.mp3")
        setTimer("stopStreamTimer", 3000, 1, playerid)
    elseif sound == "headshot" then
        playStreamFrontend(playerid, "http://136.144.207.116/soundeffects/headshot.mp3")
        setTimer("stopStreamTimer", 3000, 1, playerid)
    elseif sound == "unstoppable" then
        playStreamFrontend(playerid, "http://136.144.207.116/soundeffects/unstoppable.mp3")
        setTimer("stopStreamTimer", 2000, 1, playerid)
    elseif sound == "extermination" then
        playStreamFrontend(playerid, "http://136.144.207.116/soundeffects/extermination.mp3")
        setTimer("stopStreamTimer", 3000, 1, playerid)
    else print("Didn't find sound " .. sound) end
end

function Account:drawGui()
    wipeDrawClass(self.playerid, -1)
    
    drawText(self.playerid, 2, 0.85, 0.940, 0.2, 0.2, "Kills: " .. self.kills, 0, 0xE94B3CFF)
    drawRect(self.playerid, 1, 0.87, 0.945, 0.075, 0.055, 0x2D292680)

    drawText(self.playerid, 4, 0.93, 0.940, 0.2, 0.2, "Spree: " .. self.spree, 0, 0xE94B3CFF)
    drawRect(self.playerid, 3, 0.95, 0.945, 0.075, 0.055, 0x2D292680)
end

function stopStreamTimer(playerid)
    stopPlayerStreams(playerid)
    print("stopping stream for " .. playerid)
end

-- 13985 head