local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvents = ReplicatedStorage.Events.RemoteEvents
local BindableEvents = ReplicatedStorage.Events.BindableEvents
local HttpService = game:GetService("HttpService")
local ServerScriptService = game:GetService("ServerScriptService")
local InstanceCreator = require(ReplicatedStorage.Shared.InstanceCreator)
local Drink = require(ServerScriptService.Server.Gameplay.Requests.Drink)
local function GiveDrink(Player: Player, Name: string)
	if not Player or not Name then
		return
	end
	local Drinks = Player.Drinks
	local Decoded = HttpService:JSONDecode(Drinks.Value)
	if Decoded and typeof(Decoded) == "table" then
		local OwnsDrink = table.find(Decoded, Name)
		if OwnsDrink == nil then
			table.insert(Decoded, Name)
			Drinks.Value = HttpService:JSONEncode(Decoded)
		end
	end
end
return {
	-- vip pack
	[1161118205] = function(Player: Player, init: boolean)
		Player.Vip.Value = true
		Player.Cash.Value += 2500
		Player.Diamonds.Value += 10
		GiveDrink(Player, "Exclusive Potion")
		if init == nil then
			RemoteEvents.Notify:FireClient(Player, "Purchase Successful", Color3.fromRGB(135, 255, 0))
		end
		return true
	end,

	-- starter pack
	[1165610477] = function(Player: Player, init: boolean)
		if Player.StarterPack.Value == false then
			Player.StarterPack.Value = true
			Player.Cash.Value += 300
			Player.Power.Value += 1500
			GiveDrink(Player, "FireBlade Potion")
			if init == nil then
				RemoteEvents.Notify:FireClient(Player, "Purchase Successful", Color3.fromRGB(135, 255, 0))
			end
		end
		return true
	end,

	-- x2 cash
	[1162324213] = function(Player: Player, init: boolean)
		Player.DoubleCash.Value = true
		if init == nil then
			RemoteEvents.Notify:FireClient(Player, "Purchase Successful", Color3.fromRGB(135, 255, 0))
		end
		return true
	end,

	-- x2 power
	[1167162151] = function(Player: Player, init: boolean)
		Player.DoublePower.Value = true
		if init == nil then
			RemoteEvents.Notify:FireClient(Player, "Purchase Successful", Color3.fromRGB(135, 255, 0))
		end
		return true
	end,

	-- x2 Diamonds
	[1160422237] = function(Player: Player, init: boolean)
		Player.DoubleDiamonds.Value = true
		if init == nil then
			RemoteEvents.Notify:FireClient(Player, "Purchase Successful", Color3.fromRGB(135, 255, 0))
		end
		return true
	end,

	-- Auto Drink
	[1160578258] = function(Player: Player, init: boolean)
		Player.AutoDrink.Value = true
		if init == nil then
			RemoteEvents.Notify:FireClient(Player, "Purchase Successful", Color3.fromRGB(135, 255, 0))
		end
		return true
	end,

	-- Jetpack
	[1176674874] = function(Player: Player, init: boolean)
		local Character = Player.Character
		if Character then
			local UpperTorso = Character:FindFirstChild("UpperTorso")
			if UpperTorso then
				local Attachment = Instance.new("Attachment")
				Attachment.Name = "Jetpack"
				Attachment.Parent = UpperTorso
				Attachment.CFrame = CFrame.new(0, 0, 1) * CFrame.Angles(0, math.rad(90), 0)
				local JetpackModel = ReplicatedStorage.Assets.Jetpack:Clone()
				if JetpackModel then
					JetpackModel:PivotTo(Attachment.WorldCFrame)
					local PrimaryPart = JetpackModel.PrimaryPart
					local NewWeldConstraint = Instance.new("WeldConstraint")
					NewWeldConstraint.Part0 = UpperTorso
					NewWeldConstraint.Part1 = PrimaryPart
					NewWeldConstraint.Parent = PrimaryPart
					JetpackModel.Parent = Character
					local ScriptOBJToEnable = JetpackModel:FindFirstChildOfClass("Script")
					if ScriptOBJToEnable then
						ScriptOBJToEnable.Enabled = true
					end
				end
			end
		end
		if init == nil then
			RemoteEvents.Notify:FireClient(Player, "Purchase Successful", Color3.fromRGB(135, 255, 0))
		end
		return true
	end,

	-- DoubleOfflineGains
	[1235666503] = function(Player: Player, init: boolean)
		local DoubleOfflineGains = Player:FindFirstChild("DoubleOfflineGains")
		if DoubleOfflineGains then
			DoubleOfflineGains.Value = true
		end
		if init == nil then
			RemoteEvents.Notify:FireClient(Player, "Purchase Successful", Color3.fromRGB(135, 255, 0))
		end
		return true
	end,

	-- DoubleDrinkSpeed
	[1235487324] = function(Player: Player, init: boolean)
		local DoubleDrinkSpeed = Player:FindFirstChild("DoubleDrinkSpeed")
		if DoubleDrinkSpeed then
			DoubleDrinkSpeed.Value = true
		end
		if init == nil then
			RemoteEvents.Notify:FireClient(Player, "Purchase Successful", Color3.fromRGB(135, 255, 0))
		end
		return true
	end,

	-- Balloons
	[1235700874] = function(Player: Player, init: boolean)
		local Character = Player.Character or Player.CharacterAdded:Wait()
		if Character then
			local UpperTorso = Character:FindFirstChild("UpperTorso")
			if UpperTorso then
				local NewAttachment = InstanceCreator("Attachment", "BalloonAttachment", UpperTorso) :: Attachment
				NewAttachment.Position = Vector3.new(0, 0, 1)
				NewAttachment.Visible = false
				local BalloonAsset = ReplicatedStorage.Assets.Balloons_GameAsset:Clone()
				if BalloonAsset then
					BalloonAsset.Parent = Character
					BalloonAsset:PivotTo(NewAttachment.WorldCFrame)
					local NewWeld = Instance.new("WeldConstraint")
					NewWeld.Parent = BalloonAsset
					NewWeld.Part0 = UpperTorso
					NewWeld.Part1 = BalloonAsset
				end
			end
		end
		if init == nil then
			RemoteEvents.Notify:FireClient(Player, "Purchase Successful", Color3.fromRGB(135, 255, 0))
		end
		return true
	end,
}
