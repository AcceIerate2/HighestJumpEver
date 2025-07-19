local PlayerService = game:GetService("Players")
local Player = PlayerService.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Hud = PlayerGui:WaitForChild("Frames")

local TweenService = game:GetService("TweenService")
local TweenConfig = TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)

local SoundService = game:GetService("SoundService")
local EnterSFX = SoundService:WaitForChild("Enter")
local WhooshSFX = SoundService:WaitForChild("Whoosh")

local SectionValues = {
	["Start"] = 0,
	["StarterPack"] = 0.115,
	["Gamepasses"] = 0.25,
	["Cash"] = 0.4525,
	["Power"] = 0.63,
	["Diamonds"] = 0.810,
}

local function ToSection(SpecificFrameToOpen: CanvasGroup, SectionName: string)
	if SectionValues[SectionName] == nil then
		return
	end
	if SpecificFrameToOpen.Name == "Shop" then
		SpecificFrameToOpen:WaitForChild("Frame"):WaitForChild("Drinks").Visible = false
		SpecificFrameToOpen:WaitForChild("Frame"):WaitForChild("Robux").Visible = true
		local GoalPosition = Vector2.new(
			0,
			SpecificFrameToOpen:WaitForChild("Frame"):WaitForChild("Robux").AbsoluteCanvasSize.Y
				* SectionValues[SectionName]
		)
		WhooshSFX:Play()
		local Tween = TweenService:Create(
			SpecificFrameToOpen:WaitForChild("Frame"):WaitForChild("Robux"),
			TweenInfo.new(0.15),
			{ ["CanvasPosition"] = GoalPosition }
		)
		Tween:Play()
		Tween.Completed:Wait()
	end
end

local function OpenFrame(SpecificFrameToOpen: CanvasGroup, CustomSectionIfAny: string | nil): boolean
	local GroupTransparencyGoal = 0
	if SpecificFrameToOpen.GroupTransparency == 1 then
		GroupTransparencyGoal = 0
		SpecificFrameToOpen.Visible = true
	elseif SpecificFrameToOpen.GroupTransparency == 0 then
		GroupTransparencyGoal = 1
	end
	EnterSFX:Play()
	if CustomSectionIfAny == nil or CustomSectionIfAny ~= nil and GroupTransparencyGoal == 0 then
		local Tween =
			TweenService:Create(SpecificFrameToOpen, TweenConfig, { ["GroupTransparency"] = GroupTransparencyGoal })
		Tween:Play()
		Tween.Completed:Wait()
	end
	if GroupTransparencyGoal == 1 then
		if CustomSectionIfAny == nil then
			SpecificFrameToOpen.Visible = false
		end
	end
	if CustomSectionIfAny then
		if CustomSectionIfAny == "ShowRobuxFrame" then
			SpecificFrameToOpen:WaitForChild("Frame"):WaitForChild("Robux").Visible = true
			SpecificFrameToOpen:WaitForChild("Frame"):WaitForChild("Drinks").Visible = false
		else
			ToSection(SpecificFrameToOpen, CustomSectionIfAny)
		end
	elseif CustomSectionIfAny == nil and SpecificFrameToOpen.Name == "Shop" then
		SpecificFrameToOpen:WaitForChild("Frame"):WaitForChild("Robux").Visible = false
		SpecificFrameToOpen:WaitForChild("Frame"):WaitForChild("Drinks").Visible = true
	end
	return true
end

local function CloseAll(FrameNotToClose: CanvasGroup)
	for index, Canvas in pairs(Hud:GetChildren()) do
		if Canvas == FrameNotToClose or not Canvas:IsA("CanvasGroup") or Canvas:HasTag("AlwaysVisible") then
			continue
		end
		local Tween = TweenService:Create(Canvas, TweenConfig, { GroupTransparency = 1 })
		Tween:Play()
		Tween.Completed:Once(function()
			Canvas.Visible = false
		end)
	end
end

local function CanToggle(): boolean
	return true
end

return function(SpecificFrameToOpenString: string, CustomSectionIfAny: string | nil): boolean
	local CanToggleCanvas = CanToggle()
	if CanToggleCanvas == false then
		return false
	end
	local SpecificFrameToOpen = Hud:FindFirstChild(SpecificFrameToOpenString) :: CanvasGroup | nil
	if SpecificFrameToOpenString then
		CloseAll(SpecificFrameToOpen)
		return OpenFrame(SpecificFrameToOpen, CustomSectionIfAny) :: boolean
	end
end
