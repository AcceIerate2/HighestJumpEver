local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvents = ReplicatedStorage.Events.RemoteEvents
local BindableEvents = ReplicatedStorage.Events.BindableEvents

local NumberShortnerModule = require(ReplicatedStorage.Shared.NumberShortner)
local PlayerService = game:GetService("Players")

return {
	-- 250 cash
	[3267331134] = function(Player: Player)
		Player.Cash.Value += 250
		RemoteEvents.Notify:FireClient(Player, "Purchase Successful", Color3.fromRGB(135, 255, 0))
		return true
	end,

	-- 7.5k cash
	[3267331513] = function(Player: Player)
		Player.Cash.Value += 7500
		RemoteEvents.Notify:FireClient(Player, "Purchase Successful", Color3.fromRGB(135, 255, 0))
		return true
	end,

	-- 25k cash
	[3267331759] = function(Player: Player)
		Player.Cash.Value += 25000
		RemoteEvents.Notify:FireClient(Player, "Purchase Successful", Color3.fromRGB(135, 255, 0))
		return true
	end,

	-- 150k Cash
	[3294906322] = function(Player: Player)
		Player.Cash.Value += 150000
		RemoteEvents.Notify:FireClient(Player, "Purchase Successful", Color3.fromRGB(135, 255, 0))
		return true
	end,

	-- 500 power
	[3267332062] = function(Player: Player)
		Player.Power.Value += 500
		RemoteEvents.Notify:FireClient(Player, "Purchase Successful", Color3.fromRGB(135, 255, 0))
		return true
	end,

	-- 50k power
	[3267332249] = function(Player: Player)
		Player.Power.Value += 50000
		RemoteEvents.Notify:FireClient(Player, "Purchase Successful", Color3.fromRGB(135, 255, 0))
		return true
	end,

	-- 100k power
	[3267332566] = function(Player: Player)
		Player.Power.Value += 100000
		RemoteEvents.Notify:FireClient(Player, "Purchase Successful", Color3.fromRGB(135, 255, 0))
		return true
	end,

	-- 1m power
	[3294905892] = function(Player: Player)
		Player.Power.Value += 1000000
		RemoteEvents.Notify:FireClient(Player, "Purchase Successful", Color3.fromRGB(135, 255, 0))
		return true
	end,

	-- 5 diamonds
	[3267332834] = function(Player: Player)
		Player.Diamonds.Value += 5
		RemoteEvents.Notify:FireClient(Player, "Purchase Successful", Color3.fromRGB(135, 255, 0))
		return true
	end,

	-- 10 Diamonds
	[3267333058] = function(Player: Player)
		Player.Diamonds.Value += 10
		RemoteEvents.Notify:FireClient(Player, "Purchase Successful", Color3.fromRGB(135, 255, 0))
		return true
	end,

	-- 30 Diamonds
	[3267333259] = function(Player: Player)
		Player.Diamonds.Value += 30
		RemoteEvents.Notify:FireClient(Player, "Purchase Successful", Color3.fromRGB(135, 255, 0))
		return true
	end,

	-- 100 Diamonds
	[3294904748] = function(Player: Player)
		Player.Diamonds.Value += 100
		RemoteEvents.Notify:FireClient(Player, "Purchase Successful", Color3.fromRGB(135, 255, 0))
		return true
	end,

	-- Skip Gift Reward
	[3271381820] = function(Player: Player)
		Player:SetAttribute("GiftSkipped", true)
		RemoteEvents.Notify:FireClient(Player, "Purchase Successful", Color3.fromRGB(135, 255, 0))
		return true
	end,

	-- 2 Robux devproduct [200 Power]
	[3274288150] = function(Player: Player)
		Player.Power.Value += 200
		RemoteEvents.Notify:FireClient(Player, "Purchase Successful", Color3.fromRGB(135, 255, 0))
		return true
	end,

	-- 500 Cash
	[3274293350] = function(Player: Player)
		Player.Cash.Value += 500
		RemoteEvents.Notify:FireClient(Player, "Purchase Successful", Color3.fromRGB(135, 255, 0))
		return true
	end,

	-- 1 Spin
	[3295364016] = function(Player: Player)
		Player.Spins.Value += 1
		RemoteEvents.Notify:FireClient(Player, "Purchase Successful", Color3.fromRGB(135, 255, 0))
		return true
	end,

	-- 5 Spins
	[3295364488] = function(Player: Player)
		Player.Spins.Value += 5
		RemoteEvents.Notify:FireClient(Player, "Purchase Successful", Color3.fromRGB(135, 255, 0))
		return true
	end,

	-- 10 Spins
	[3295364758] = function(Player: Player)
		Player.Spins.Value += 10
		RemoteEvents.Notify:FireClient(Player, "Purchase Successful", Color3.fromRGB(135, 255, 0))
		return true
	end,

	-- x2 Power Boost [Stackable] [4:30]
	[3295628729] = function(Player: Player)
		Player.PowerBoost.Value += 2
		task.delay(270, function()
			if Player then
				Player.PowerBoost.Value -= 2
			end
		end)
		RemoteEvents.Notify:FireClient(Player, "Purchase Successful", Color3.fromRGB(135, 255, 0))
		return true
	end,
}
