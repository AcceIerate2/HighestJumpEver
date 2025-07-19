local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local Upgrades = require(ReplicatedStorage:WaitForChild("UpgradeData"))

local TweenService = game:GetService("TweenService")
local TweenConfiguration = TweenInfo.new(0.11, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, true, 0)

local function ToggleViewAnimation(Frame: Frame)
	Frame.Size = Frame:GetAttribute("Size") :: UDim2
	local SizeX = Frame.Size.X.Scale / 1.1
	local SizeY = Frame.Size.Y.Scale / 1.1
	local SmallerSize = UDim2.fromScale(SizeX, SizeY)
	local Tween = TweenService:Create(Frame, TweenConfiguration, {
		["Size"] = SmallerSize,
	})
	Tween:Play()
end

local function ResetSelectionBtns(CanvasGroup: CanvasGroup)
	if not CanvasGroup then
		return
	end
	local SelectionFrame = CanvasGroup:WaitForChild("Frame"):WaitForChild("ScrollingFrame")
	for _Index, Frame in pairs(SelectionFrame:GetChildren()) do
		if Frame:IsA("GuiButton") then
			local UIStroke = Frame:FindFirstChild("UIStroke")
			if UIStroke then
				UIStroke.Color = Color3.fromRGB(0, 0, 0)
			end
		end
	end
end

local function Update(Name: string, Player: Player, PlayerGui: PlayerGui, init: boolean)
	local CanvasGroup = PlayerGui:WaitForChild("Frames"):WaitForChild("Upgrades"):WaitForChild("Frame")
	local ViewingFrame = CanvasGroup:WaitForChild("View")
	local PlayerUpgradeData = HttpService:JSONDecode(Player:WaitForChild("UpgradeData").Value)
	if PlayerUpgradeData then
		local Level = PlayerUpgradeData[Name]

		local MultiplierText = nil
		local Price = nil
		if Level == 0 then
			MultiplierText = Upgrades[Name]["DefaultMultiplierText"]
		elseif Level > 0 and Level < 4 then
			MultiplierText = Upgrades[Name]["Levels"][Level - 1][2]
		elseif Level >= #Upgrades[Name]["Levels"] then
			MultiplierText = Upgrades[Name]["Levels"][Level - 1][2]
			Price = ""
		end

		local Description = Upgrades[Name]["Description"]
		if Price == nil then
			Price = `💎 {Upgrades[Name]["Levels"][Level][1]}`
		end

		ViewingFrame:WaitForChild("Price").Text = Price
		if init then
			ViewingFrame:WaitForChild("Multiplier").Text = `{MultiplierText}`
		else
			if Name == "Fast Chug" then
				ViewingFrame:WaitForChild("Multiplier").Text = `Current: {MultiplierText}`
			else
				ViewingFrame:WaitForChild("Multiplier").Text = `Current: x{MultiplierText}`
			end
		end
		ViewingFrame:WaitForChild("Level").Text = `Level {Level}`
		ViewingFrame:WaitForChild("Description").Text = Description
		ViewingFrame:WaitForChild("Title"):WaitForChild("TextLabel").Text = Name
		ViewingFrame:WaitForChild("Upgrade"):SetAttribute("SelectedUpgrade", Name)

		ResetSelectionBtns(CanvasGroup)
		local UpgradeSelectionBtn =
			CanvasGroup:WaitForChild("Frame"):WaitForChild("ScrollingFrame"):FindFirstChild(Name)
		if UpgradeSelectionBtn then
			local UIStroke = UpgradeSelectionBtn:FindFirstChild("UIStroke")
			if UIStroke then
				UIStroke.Color = Color3.fromRGB(255, 255, 255)
			end
		end
		SoundService:WaitForChild("SelectUpgrade"):Play()
		ToggleViewAnimation(ViewingFrame)
	end
end

return function(Button: GuiButton | string, Player: Player, PlayerGui: PlayerGui, init: boolean)
	local Name = nil
	if typeof(Button) == "string" then
		Name = Button
	elseif typeof(Button) == "Instance" then
		Name = Button.Name
	end
	Update(Name, Player, PlayerGui, init)
end
