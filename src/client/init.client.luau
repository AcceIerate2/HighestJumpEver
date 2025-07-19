local PlayerService = game:GetService("Players")
local Player = PlayerService.LocalPlayer
local _Loaded = Player:WaitForChild("Loaded")

local PrepareModule = require(script:WaitForChild("Prepare"))
PrepareModule(Player)

local UserInterfaceModule = require(script:WaitForChild("UserInterface"))
UserInterfaceModule(Player)

local InputsModule = require(script:WaitForChild("Inputs"))
InputsModule()
