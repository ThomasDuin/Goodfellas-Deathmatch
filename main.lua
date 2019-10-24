
-- Tools
require("/scripts/utils/utilis")
require("/scripts/scriptLoader")

-- For keeping data
require("/scripts/classes/singleton")

-- I load the following scripts like this so I can reload them whenever using the rcon script
require("/scripts/rcon")

Globals = Singleton()
Globals.accounts = {}
Globals.commands = {}
Globals.commands.guest = {}
Globals.commands.chat = {}
Globals.commands.misc = {}
Globals.constants = {}
Globals.constants.distanceChat = 10
Globals.constants.distanceShout = 20
Globals.constants.distanceWhisper = 5

-- Modules
require("/scripts/account/main")
require("/scripts/roleplay/main")
require("/scripts/deathmatch/main")

-- Events
require("/scripts/mainevents")

createVehicle(51, -586.54663085938, -863.50726318359, 4.340398311615, 359.98690795898, 0, 0, 0, 0, 0, 0, 1)

-- local npcId = npcCreate("Niko", 0, -586.64819335938, -878.20764160156, 3.8428587913513, -1, "", 1)
-- npcAddFootTask(npcId, -586.64819335938, -878.20764160156, 3.8428587913513, -586.64819335938, -878.20764160156, 3.8428587913513, 88.169281005859, 228, 0, 14000)
-- npcPlayTasks(npcId, true)