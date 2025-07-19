local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local NumberShortner = require(ReplicatedStorage.Shared.NumberShortner)
local CanvasModule =
	require(script.Parent.Parent:WaitForChild("Buttons"):WaitForChild("Canvas"):WaitForChild("CanvasToggler"))
return function(Player: Player, PlayerGui: PlayerGui)
	ReplicatedStorage:WaitForChild("Events")
		:WaitForChild("RemoteEvents")
		:WaitForChild("ShowTutorial").OnClientEvent
		:Connect(function()
			CanvasModule("Tutorial")
			repeat
				task.wait(0.1)
			until PlayerGui:WaitForChild("Frames"):WaitForChild("Tutorial").Visible == false
			CanvasModule("DailyRewards")
			repeat
				task.wait(0.1)
			until PlayerGui:WaitForChild("Frames"):WaitForChild("DailyRewards").Visible == false
			CanvasModule("StarterPack")
			SoundService:WaitForChild("Cash"):Play()
		end)
	local Connection = PlayerGui:WaitForChild("Frames")
		:WaitForChild("Tutorial")
		:GetAttributeChangedSignal("Current")
		:Connect(function()
			PlayerGui:WaitForChild("Frames"):WaitForChild("Tutorial"):WaitForChild("PageNumber").Text =
				`{PlayerGui:WaitForChild("Frames"):WaitForChild("Tutorial"):GetAttribute("Current")}/8`
		end)
	ReplicatedStorage:WaitForChild("Events")
		:WaitForChild("RemoteEvents")
		:WaitForChild("ShowDailyRewards").OnClientEvent
		:Connect(function()
			CanvasModule("DailyRewards")
			repeat
				task.wait()
			until PlayerGui:WaitForChild("Frames"):WaitForChild("DailyRewards").Visible == false
			local OfflineReward = Player:GetAttribute("OfflineReward")
			if OfflineReward and typeof(OfflineReward) == "number" then
				PlayerGui:WaitForChild("Frames")
					:WaitForChild("OfflineProgress")
					:WaitForChild("Frame")
					:WaitForChild("Power").Text =
					`{NumberShortner(OfflineReward)} Power`
				CanvasModule("OfflineProgress")
			end
		end)
end
