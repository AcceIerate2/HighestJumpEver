local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SharedFolder = ReplicatedStorage:WaitForChild("Shared")
local AnimationModule = require(SharedFolder:WaitForChild("Animations"))

local function removeVelocity(Character: Model)
	for index, BasePart in pairs(Character:GetDescendants()) do
		if BasePart:IsA("BasePart") then
			BasePart.AssemblyLinearVelocity = Vector3.zero
			BasePart.AssemblyAngularVelocity = Vector3.zero
			BasePart.Velocity = Vector3.zero
		end
	end
end

local function ToggleEndJumpBtn(Player: Player, Toggle: boolean): boolean
	if not Player or Toggle == nil then
		return false
	end
	if typeof(Toggle) == "boolean" and Player:IsA("Player") then
		local PlayerGui = Player:FindFirstChild("PlayerGui")
		if PlayerGui then
			PlayerGui.Hud.Frame.EndJump.Visible = Toggle
			return true
		end
	end
	return false
end

local SoundHeights = {
	[1000] = "Land_Custom",
	[100000] = "MidLand_Custom",
	[100000000000000000000000000000] = "HugeLand_Custom",
}

local RunService = game:GetService("RunService")
return function(Player: Player)
	local IsJumping = Player:FindFirstChild("IsJumping")
	if IsJumping.Value == true then
		return
	end
	IsJumping.Value = true
	local Character = Player.Character
	if Character ~= nil then
		Character:SetAttribute("JumpEnded", false)
		local Humanoid = Character:FindFirstChildOfClass("Humanoid")
		local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
		if Humanoid ~= nil and HumanoidRootPart ~= nil then
			local JumpHeightValue = Player.Power.Value
			if JumpHeightValue < 10 then
				JumpHeightValue = 10
			end
			local Response = AnimationModule(Player, "JumpStartingAnimation")
			if Response == false then
				task.wait(3)
			end
			local SecondResponse = AnimationModule(Player, "JumpMiddleAnimation")
			Humanoid.WalkSpeed = 0.1
			--ReplicatedStorage.Events.RemoteEvents.ToggleMovement:FireClient(Player, "Movement", false)
			Humanoid.JumpHeight = JumpHeightValue
			Humanoid.Jump = true

			local Status, NetworkResponse = pcall(function()
				HumanoidRootPart:SetNetworkOwner(nil)
			end)
			if Status == false then
				warn(NetworkResponse)
			end

			local ExtraMultipliers = 0
			local HasJetpack = Character:FindFirstChild("Jetpack")
			if HasJetpack then
				ExtraMultipliers += 4
			end
			local HasBalloons = Character:FindFirstChild("Balloons_GameAsset")
			if HasBalloons then
				ExtraMultipliers += 2
			end
			local ClaimedJumpCoil = Player:FindFirstChild("ClaimedJumpCoil")
			if ClaimedJumpCoil.Value == true then
				ExtraMultipliers += 0.5
			end
			HumanoidRootPart.Velocity = Vector3.new(
				HumanoidRootPart.Velocity.X,
				Player.Power.Value / 1.25 * Player:WaitForChild("JumpPowerMultiplier").Value + ExtraMultipliers,
				HumanoidRootPart.Velocity.Z
			)

			ToggleEndJumpBtn(Player, true)
			local WhooshSFX = HumanoidRootPart:FindFirstChild("Whoosh_Custom")
			if WhooshSFX then
				WhooshSFX:Play()
			end
			repeat
				task.wait()
			until HumanoidRootPart.Velocity.Y < 0 or Character:GetAttribute("JumpEnded") == true
			Character:SetAttribute("JumpEnded", false)
			Humanoid.JumpHeight = 0
			local CashToGive = HumanoidRootPart.Position.Y / 3.5
			local DoubleCash = Player:FindFirstChild("DoubleCash")
			local ExtraMultiplier = 1
			if DoubleCash.Value == true then
				ExtraMultiplier = 2
			end
			local TotalCash = CashToGive * ExtraMultiplier * Player.CashMultiplier.Value
			Player.Cash.Value += TotalCash
			ReplicatedStorage.Events.RemoteEvents.Cash:FireClient(Player, TotalCash)
			local HighestHeight = HumanoidRootPart.Position.Y
			removeVelocity(Character)
			repeat
				RunService.Stepped:Wait()
			until Humanoid:GetState() == Enum.HumanoidStateType.Landed
				or Humanoid:GetState() == Enum.HumanoidStateType.Running
			ToggleEndJumpBtn(Player, false)
			removeVelocity(Character)
			HumanoidRootPart.Anchored = true
			removeVelocity(Character)
			local YAxisRotation = HumanoidRootPart.Orientation.Y
			HumanoidRootPart.CFrame = CFrame.new(
				HumanoidRootPart.Position.X,
				Player.RootCFrame.Value.Y,
				HumanoidRootPart.Position.Z
			) * CFrame.Angles(0, math.rad(YAxisRotation), 0)
			--ReplicatedStorage.Events.RemoteEvents.ToggleMovement:FireClient(Player, "Movement", true)
			removeVelocity(Character)
			Character.LeftFoot.Impact:Emit(3)
			local LandSFX = nil
			for Height, SoundName in pairs(SoundHeights) do
				if HighestHeight <= Height then
					LandSFX = HumanoidRootPart:FindFirstChild(SoundName)
					break
				end
			end
			if LandSFX then
				LandSFX:Play()
			elseif LandSFX == nil then
				LandSFX = HumanoidRootPart:FindFirstChild("Land_Custom")
				if LandSFX then
					LandSFX:Play()
				end
			end
			local ThirdResponse = AnimationModule(Player, "JumpEndingAnimation")
			task.wait(1.75)
			removeVelocity(Character)
			ReplicatedStorage.Events.RemoteEvents.RemoveVelocity:FireClient(Player)
			HumanoidRootPart.Anchored = false
			for index = 10, 0, -1 do
				removeVelocity(Character)
				task.wait()
			end
			local Status, NetworkResponse = pcall(function()
				HumanoidRootPart:SetNetworkOwner(Player)
			end)
			if Status == false then
				warn(NetworkResponse)
			end
			Humanoid.WalkSpeed = 20
			local GaspSFX = HumanoidRootPart:FindFirstChild("Gasp_Custom")
			if GaspSFX then
				GaspSFX:Play()
			end
		end
	end
	task.wait(1)
	IsJumping.Value = false
end
