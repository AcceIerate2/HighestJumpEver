local ZoneLimits = require(script.ZoneLimits)
local LightingService = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvents = ReplicatedStorage.Events.RemoteEvents
local RunService = game:GetService("RunService")
local HeightConnection = nil
local BadgeService = game:GetService("BadgeService")

local function AwardBadge(Player: Player, SkyName: string)
	if SkyName ~= "Ground" then
		local Sky = LightingService.Skies:FindFirstChild(SkyName)
		if Sky then
			local BadgeId = Sky:GetAttribute("BadgeId")
			if BadgeId then
				local Status, Response = pcall(function()
					BadgeService:AwardBadge(Player.UserId, BadgeId)
				end)
				if Status == false then
					warn(Response)
				end
			end
		end
	end
end

return function(Player: Player, Humanoid: Humanoid, HumanoidRootPart: HumanoidRootPart)
	Player.CurrentAltitude.Value = HumanoidRootPart.Position.Y
	HeightConnection = RunService.Heartbeat:Connect(function()
		Player.CurrentAltitude.Value = HumanoidRootPart.Position.Y
		local ChosenZone = nil
		local index = 1
		for Index, ZoneData in pairs(ZoneLimits) do
			if Player.CurrentAltitude.Value >= ZoneData[1] then
				ChosenZone = ZoneData
				index = Index
			end
		end
		if ChosenZone == nil then
			ChosenZone = ZoneLimits[1]
			index = 1
		end
		Player.BeginValue.Value = ChosenZone[1]
		if index then
			if index + 1 <= #ZoneLimits then
				Player.EndValue.Value = ZoneLimits[index + 1][1]
			end
			if ChosenZone and typeof(ChosenZone) == "table" and #ChosenZone >= 2 then
				if Player.SkyName.Value ~= ChosenZone[2] then
					Player.SkyName.Value = ChosenZone[2]
					RemoteEvents.UpdateSky:FireClient(Player, ChosenZone)
					AwardBadge(Player, ChosenZone[2])
				end
			end
			local State = Humanoid:GetState()
			if State == Enum.HumanoidStateType.Freefall or State == Enum.HumanoidStateType.Jumping then
				Player.CurrentJump.Value = HumanoidRootPart.Position.Y
				if Player.CurrentAltitude.Value > Player.HighestJump.Value then
					Player.HighestJump.Value = Player.CurrentAltitude.Value
				end
			else
				Player.CurrentJump.Value = 0
			end
		end
	end)
end
