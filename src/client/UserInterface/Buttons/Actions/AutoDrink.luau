local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPlayer = game:GetService("StarterPlayer")
local Prompt = require(StarterPlayer.StarterPlayerScripts.Client.UserInterface.Buttons.Prompt)
return function(Button: GuiButton, Player: Player, PlayerGui: PlayerGui)
	local Response = ReplicatedStorage:WaitForChild("Events")
		:WaitForChild("RemoteFunctions")
		:WaitForChild("CanAutoDrink")
		:InvokeServer()
	if Response == false then
		ReplicatedStorage:WaitForChild("Events")
			:WaitForChild("BindableEvents")
			:WaitForChild("Notify")
			:Fire("Purchase the gamepass to unlock this!", Color3.fromRGB(255, 0, 0))
		Prompt(Button, Player, PlayerGui)
	end
end
