local DayInSeconds = 86400
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FormatTimeModule = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("FormatTime"))
local CountdownThread = nil
return function(Player: Player, PlayerGui: PlayerGui)
	local DailyRewardGoal = Player:WaitForChild("DailyRewardGoal")
	local MainFrame = PlayerGui:WaitForChild("Frames")
		:WaitForChild("DailyRewards")
		:WaitForChild("background")
		:WaitForChild("backdrop")
		:WaitForChild("background")
	for index, CanvasGroup in pairs(MainFrame:GetChildren()) do
		if CanvasGroup and CanvasGroup:IsA("CanvasGroup") then
			if os.time() >= DailyRewardGoal.Value then
				local LastUnlockedReward = Player:WaitForChild("LastUnlockedReward")
				if LastUnlockedReward.Value + 1 == tonumber(CanvasGroup.Name) then
					CanvasGroup.GroupColor3 = Color3.fromRGB(255, 255, 255)
					CanvasGroup:WaitForChild("UIStroke").Color = Color3.fromRGB(255, 255, 255)
					CanvasGroup:FindFirstChildOfClass("ImageButton"):WaitForChild("Day").Text = "Claim"
				elseif tonumber(CanvasGroup.Name) <= LastUnlockedReward.Value then
					CanvasGroup:FindFirstChildOfClass("ImageButton"):WaitForChild("Checkmark").Visible = true
				end
			else
				local LastUnlockedReward = Player:WaitForChild("LastUnlockedReward")
				if LastUnlockedReward.Value + 1 == tonumber(CanvasGroup.Name) then
					CanvasGroup.GroupColor3 = Color3.fromRGB(255, 255, 255)
					CanvasGroup:WaitForChild("UIStroke").Color = Color3.fromRGB(255, 255, 255)
					task.spawn(function()
						for index = DailyRewardGoal.Value - os.time(), 0, -1 do
							CanvasGroup:FindFirstChildOfClass("ImageButton"):WaitForChild("Day").Text =
								FormatTimeModule(index)
							task.wait(1)
						end
						CanvasGroup:FindFirstChildOfClass("ImageButton"):WaitForChild("Day").Text = "Claim"
					end)
				elseif tonumber(CanvasGroup.Name) <= LastUnlockedReward.Value then
					CanvasGroup:FindFirstChildOfClass("ImageButton"):WaitForChild("Checkmark").Visible = true
				end
			end
		end
	end
end
