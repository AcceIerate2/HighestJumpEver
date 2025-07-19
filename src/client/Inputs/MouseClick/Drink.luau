local TweenService = game:GetService("TweenService")
local TweenConfigurations = TweenInfo.new(1, Enum.EasingStyle.Elastic)

local SoundService = game:GetService("SoundService")
local DrinkSFX = SoundService:WaitForChild("Drink")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local NumberShortner = require(ReplicatedStorage.Shared.NumberShortner)

local function GetPosition(): UDim2
	local XPosition = math.random(0, 100) / 100
	local YPosition = math.random(17.5, 72.5) / 100
	return UDim2.fromScale(XPosition, YPosition)
end

local function GuiEffect(PlayerGui: PlayerGui, Amount: number)
	local Parent = PlayerGui:WaitForChild("DrinkEffects"):WaitForChild("Frame")
	local DrinkTemplate = Parent:WaitForChild("Template"):Clone()
	DrinkTemplate.Label.Text = `+{NumberShortner(Amount)}`
	DrinkTemplate.Visible = true
	local Position = GetPosition()
	DrinkTemplate.Parent = Parent
	DrinkTemplate.Position = UDim2.fromScale(Position.X.Scale, 1.25)
	local Tween = TweenService:Create(DrinkTemplate, TweenConfigurations, { ["Position"] = Position })
	Tween:Play()
	Tween.Completed:Wait()
	local FadingTween =
		TweenService:Create(DrinkTemplate, TweenInfo.new(0.5, Enum.EasingStyle.Linear), { ["GroupTransparency"] = 1 })
	FadingTween:Play()
	FadingTween.Completed:Wait()
	DrinkTemplate:Destroy()
	return
end

return function(Player: Player, PlayerGui: PlayerGui)
	if not Player or not PlayerGui then
		return
	end
	local Response = ReplicatedStorage:WaitForChild("Events")
		:WaitForChild("RemoteFunctions")
		:WaitForChild("Drink")
		:InvokeServer() :: boolean
	if Response ~= nil and typeof(Response) == "number" then
		task.spawn(GuiEffect, PlayerGui, Response)
		task.wait(0.2)
		DrinkSFX:Play()
	end
end
