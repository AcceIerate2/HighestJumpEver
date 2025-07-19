local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPlayer = game:GetService("StarterPlayer")
local Prompt = require(StarterPlayer.StarterPlayerScripts.Client.UserInterface.Buttons.Prompt)
local PromptPlayer =
	ReplicatedStorage:WaitForChild("Events"):WaitForChild("RemoteEvents"):WaitForChild("PromptPlayer") :: RemoteEvent
return function(Player: Player, PlayerGui: PlayerGui)
	if not Player or not PlayerGui then
		return
	end
	local _Connection = PromptPlayer.OnClientEvent:Connect(function(id: number, PromptType: string)
		if not id or not PromptType then
			return
		end
		Prompt({
			["id"] = id,
			["PromptType"] = PromptType,
		}, Player, PlayerGui)
	end)
end
