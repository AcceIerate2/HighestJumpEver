local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UpdateTimerRE = ReplicatedStorage:WaitForChild("Events"):WaitForChild("RemoteEvents"):WaitForChild("UpdateTimer")
local TimeFormatterModule = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("FormatTime"))
return function(Player: Player, PlayerGui: PlayerGui)
	if Player:WaitForChild("ClaimedFreeDrink").Value == false then
		local Label = PlayerGui:WaitForChild("FreeReward")
			:WaitForChild("Frame")
			:WaitForChild("Content")
			:WaitForChild("ToggleBtn")
			:WaitForChild("TextLabel")
		UpdateTimerRE.OnClientEvent:Connect(function(NewValue: number)
			if not NewValue then
				return
			end
			if NewValue < 1 then
				Label.Text = "Claim"
				Label.Parent.Parent:WaitForChild("Title").Text = "Claimable!"
			else
				Label.Text = TimeFormatterModule(NewValue, true)
			end
		end)
	else
		PlayerGui:WaitForChild("FreeReward").Enabled = false
	end
end
