local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Events = ReplicatedStorage.Events

local DrinkRequest = require(script.Drink)
local JumpRequest = require(script.Jump)
local RebirthRequest = require(script.Rebirths)
local EvolveRequest = require(script.Evolve)
local UpgradesRequest = require(script.Upgrades)
local EndJumpRequest = require(script.EndJump)
local PurchaseRequest = require(script.Purchase)
local ToolRequest = require(script.Tool)
local ClaimFreeRewardRequest = require(script.ClaimFreeReward)
local AutoDrinkRequest = require(script.AutoDrink)
local ClaimJumpCoilRequest = require(script.ClaimJumpCoil)
local ClaimDailyRewardRequest = require(script.ClaimDailyReward)
local SpinGoalCompletedRequest = require(script.SpinGoalCompleted)

Events.RemoteFunctions.Drink.OnServerInvoke = DrinkRequest
Events.RemoteEvents.Jump.OnServerEvent:Connect(JumpRequest)
Events.RemoteFunctions.Rebirth.OnServerInvoke = RebirthRequest
Events.RemoteFunctions.Prestige.OnServerInvoke = EvolveRequest
Events.RemoteFunctions.Upgrade.OnServerInvoke = UpgradesRequest
Events.RemoteEvents.EndJump.OnServerEvent:Connect(EndJumpRequest)
Events.RemoteFunctions.Purchase.OnServerInvoke = PurchaseRequest
Events.RemoteEvents.Tool.OnServerEvent:Connect(ToolRequest)
Events.RemoteFunctions.ClaimReward.OnServerInvoke = ClaimFreeRewardRequest
Events.RemoteFunctions.CanAutoDrink.OnServerInvoke = AutoDrinkRequest
Events.RemoteFunctions.ClaimJumpCoil.OnServerInvoke = ClaimJumpCoilRequest
Events.RemoteFunctions.ClaimDailyReward.OnServerInvoke = ClaimDailyRewardRequest
Events.RemoteEvents.SpinGoalCompleted.OnServerEvent:Connect(SpinGoalCompletedRequest)
