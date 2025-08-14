local DayInSeconds = 86400
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BadgeService = game:GetService("BadgeService")
local ServerScriptService = game:GetService("ServerScriptService")
local NotificationService = require(ServerScriptService.Server.NotificationService)
return function(Player: Player, Button: GuiButton)
	if Player == nil or Button == nil then
		return false, "Something went wrong... try again!", Color3.fromRGB(255, 0, 0)
	end
	local DailyRewardGoal = Player:FindFirstChild("DailyRewardGoal")
	if DailyRewardGoal then
		local Goal = DailyRewardGoal.Value
		if os.time() >= Goal and tonumber(Button.Parent.Name) == Player.LastUnlockedReward.Value + 1 then
			local RewardType = Button:GetAttribute("RewardType")
			if RewardType == "Cash" then
				Player.Cash.Value += Button:GetAttribute("Amount")
			elseif RewardType == "Power" then
				Player.Power.Value += Button:GetAttribute("Amount")
			elseif RewardType == "Diamonds" then
				Player.Diamonds.Value += Button:GetAttribute("Amount")
			elseif RewardType == "Gear" then
				local Name = Button:GetAttribute("Name")
				if Name == "JumpCoil" then
					if Player.ClaimedJumpCoil.Value == false then
						Player.ClaimedJumpCoil.Value = true
						local Character = Player.Character
						if Character then
							local Humanoid = Character:FindFirstChildOfClass("Humanoid")
							if Humanoid then
								Humanoid:AddAccessory(ReplicatedStorage.Assets.LeftSlipper:Clone())
								Humanoid:AddAccessory(ReplicatedStorage.Assets.RightSlipper:Clone())
								Humanoid.HipHeight += 1
							end
						end
					end
				elseif Name == "Jetpack" then
					local Character = Player.Character
					if Character then
						local HasJetpack = Character:FindFirstChild("Jetpack")
						if HasJetpack == nil then
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
					end
				end
			end
			DailyRewardGoal.Value = os.time() + DayInSeconds
			Player.LastUnlockedReward.Value = tonumber(Button.Parent.Name)
			if Player.LastUnlockedReward.Value == 7 then
				local Status, Response = pcall(function()
					BadgeService:AwardBadge(Player.UserId, 1509545108144489)
				end)
				if Status == false then
					warn(Response)
				end
			else
				NotificationService.Push(
					Player,
					`🎁 Day {Player.LastUnlockedReward.Value + 1} Reward Unlocked! Claim it now! 🚀`
				)
			end
			return true, "🎉 Claimed!", Color3.fromRGB(255, 238, 0)
		elseif os.time() < Goal and Player.LastUnlockedReward.Value < tonumber(Button.Parent.Name) then
			return false, "Not Yet! Come back tomorrow to unlock!", Color3.fromRGB(255, 0, 0)
		elseif tonumber(Button.Parent.Name) <= Player.LastUnlockedReward.Value then
			return false, "You Already Claimed this!", Color3.fromRGB(255, 0, 0)
		end
	end
	return false, "Something went wrong... try again!", Color3.fromRGB(255, 0, 0)
end
