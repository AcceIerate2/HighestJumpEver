local PlayerService = game:GetService("Players")
local Player = PlayerService.LocalPlayer
local PlayerScripts = Player:WaitForChild("PlayerScripts")
local PlayerModule = require(PlayerScripts:WaitForChild("PlayerModule"))

local Actions = {}

Actions["Movement"] = function(Toggle: boolean): boolean
	if Toggle == nil or typeof(Toggle) ~= "boolean" then
		return false
	end
	local Controls = PlayerModule:GetControls()
	if Toggle == false then
		Controls:Disable()
		task.wait(1)
		Controls:Disable()
		return true
	elseif Toggle == true then
		Controls:Enable()
		task.wait(1)
		Controls:Enable()
		return true
	end
	return false
end

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvents = ReplicatedStorage:WaitForChild("Events"):WaitForChild("RemoteEvents")
return function()
	local Connection = RemoteEvents:WaitForChild("ToggleMovement").OnClientEvent
		:Connect(function(Action: string, Toggle: boolean)
			if Action == nil or Toggle == nil then
				return
			end
			local FunctionIfAny = Actions[Action]
			if FunctionIfAny then
				local Response = FunctionIfAny(Toggle)
			end
		end)
end
