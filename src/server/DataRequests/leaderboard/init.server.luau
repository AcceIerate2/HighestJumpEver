local DataStoreService = game:GetService("DataStoreService")

local CashData = DataStoreService:GetOrderedDataStore("Cash")
local RebirthData = DataStoreService:GetOrderedDataStore("Rebirths")
local AltitudeData = DataStoreService:GetOrderedDataStore("Altitude")

local PlayerService = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local UpdateModule = require(script.update)
local DisplayModule = require(script.Display)
local _Thread = task.spawn(function()
	while task.wait(1) do
		local Players = PlayerService:GetPlayers()
		UpdateModule(CashData, Players, "Cash")
		UpdateModule(RebirthData, Players, "Rebirths")
		UpdateModule(AltitudeData, Players, "HighestAltitude")
		DisplayModule(CashData, "Cash")
		DisplayModule(RebirthData, "Rebirths")
		DisplayModule(AltitudeData, "HighestAltitude")
		ReplicatedStorage.Events.BindableEvents.LdbCountdown:Fire()
		for _Index = 90, 1, -1 do
			task.wait(1)
		end
	end
end)
