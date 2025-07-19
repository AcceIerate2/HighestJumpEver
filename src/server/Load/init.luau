local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EventsFolder = ReplicatedStorage.Events
local RemoteEventsFolder = EventsFolder.RemoteEvents
local InstanceCreatorModule = require(ReplicatedStorage.Shared.InstanceCreator)
local DataCreationModule = require(script.DataCreation)
local DataRequestsModule = require(script.Parent.DataRequests)
local CharacterModule = require(script.initializeCharacter)
local SaveThreadModule = require(script.Parent.SaveThreads)
local FreeRewardHandlerModule = require(script.FreeRewardHandler)
local JumpCoilReward = require(script.JumpCoilReward)
local OfflineProgress = require(script.Parent.OfflineProgress)
local function DataSaveLoop(Player: Player)
	local IsInSaveModule = SaveThreadModule[Player.UserId]
	if IsInSaveModule then
		if typeof(IsInSaveModule) == "thread" then
			task.cancel(IsInSaveModule)
		end
		IsInSaveModule = nil
	end
	SaveThreadModule[Player.UserId] = task.spawn(function()
		while task.wait(240) do
			local DataSaved = DataRequestsModule("Save", Player) :: boolean
			if DataSaved and typeof(DataSaved) == "boolean" and DataSaved == true then
				RemoteEventsFolder.CoreNotification:FireClient(Player)
			end
		end
	end)
end

local function OwnsDrink(Player: Player, DrinkName: string): boolean
	if not Player or not DrinkName then
		return false
	end
	local OwnedDrinks = HttpService:JSONDecode(Player.Drinks.Value)
	if typeof(OwnedDrinks) == "table" then
		return not (table.find(OwnedDrinks, DrinkName) == nil)
	end
	return false
end

return function(Player: Player)
	local LoadingScreenProgress = InstanceCreatorModule("NumberValue", "LoadingScreenProgress", Player)
	CharacterModule(Player)
	LoadingScreenProgress.Value = 0.25
	local DataObjectsCreated = DataCreationModule(Player) :: boolean
	if typeof(DataObjectsCreated) == "boolean" and DataObjectsCreated == true then
		LoadingScreenProgress.Value = 0.5
		local DataSynced = DataRequestsModule("Get", Player) :: boolean
		if typeof(DataSynced) == "boolean" and DataSynced == true then
			OfflineProgress(Player)

			local OwnsLightningPotion = OwnsDrink(Player, "Lightning Potion")
			if OwnsLightningPotion then
				Player.ClaimedFreeDrink.Value = true
			end

			InstanceCreatorModule("BoolValue", "DataSynced", Player)
			LoadingScreenProgress.Value = 0.75
			DataSaveLoop(Player)
			LoadingScreenProgress.Value = 1
			InstanceCreatorModule("BoolValue", "Loaded", Player)
			print("Loaded Player: " .. Player.Name)
			local Character = Player.Character or Player.CharacterAdded:Wait()
			if Character then
				local Humanoid = Character:FindFirstChild("Humanoid")
				if Humanoid then
					Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
				end
				Character:SetAttribute("JumpEnded", false)
				FreeRewardHandlerModule(Player)
				JumpCoilReward(Player)
			end
			ReplicatedStorage.Events.BindableEvents.PlayerJoin:Fire(Player)
		end
	end
end
