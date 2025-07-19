local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DrinkFolder = ReplicatedStorage:WaitForChild("DrinkModels")
local ViewportDisplayModule = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("ViewportDisplay"))
local function AddTemplate(DataModel: Tool, ButtonTemplate: GuiButton, Parent: ScrollingFrame)
	local NewTemplate = ButtonTemplate:Clone()
	NewTemplate.Name = DataModel.Name
	if DataModel:GetAttribute("Icon") == nil then
		local ViewportFrame = NewTemplate:WaitForChild("ViewportFrame")
		ViewportDisplayModule(DataModel, ViewportFrame)
	else
		local NewImageLabel = Instance.new("ImageLabel")
		NewImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		NewImageLabel.Position = UDim2.fromScale(0.5, 0.5)
		NewImageLabel.Size = UDim2.fromScale(1, 1)
		NewImageLabel.BackgroundTransparency = 1
		NewImageLabel.Image = "rbxassetid://" .. tostring(DataModel:GetAttribute("Icon"))
		NewImageLabel.Parent = NewTemplate:WaitForChild("ViewportFrame")
		NewTemplate:WaitForChild("ViewportFrame").Size = UDim2.fromScale(0.9, 0.9)
	end
	if DataModel:HasTag("RobuxDrink") == true and DataModel:HasTag("FreeDrink") == false then
		NewTemplate:SetAttribute("id", DataModel:GetAttribute("id"))
		NewTemplate:SetAttribute("PromptType", "Pass")
		NewTemplate:WaitForChild("UIStroke").Color = Color3.fromRGB(255, 255, 255)
		local UIGradient = ReplicatedStorage:WaitForChild("UIGradient"):Clone()
		UIGradient.Parent = NewTemplate:WaitForChild("UIStroke")
		NewTemplate.BackgroundColor3 = Color3.fromRGB(77, 25, 99)
		UIGradient:Clone().Parent = NewTemplate
	elseif DataModel:HasTag("SpinReward") or DataModel:HasTag("FreeDrink") then
		if DataModel:HasTag("SpinReward") then
			NewTemplate:WaitForChild("Background").Image = "rbxassetid://109816839153441"
		elseif DataModel:HasTag("FreeDrink") then
			NewTemplate.BackgroundColor3 = Color3.fromRGB(82, 38, 48)
			NewTemplate:WaitForChild("Background").Image = "rbxassetid://99962424896580"
		end
		NewTemplate:WaitForChild("Background").Visible = true
	end
	NewTemplate.Visible = true
	NewTemplate.Parent = Parent
end
return function(_Player: Player, PlayerGui: PlayerGui)
	local CanvasGroup = PlayerGui:WaitForChild("Frames"):WaitForChild("Shop"):WaitForChild("Frame")
	local DrinkFrame = CanvasGroup:WaitForChild("Drinks"):WaitForChild("Selection"):WaitForChild("ScrollingFrame")
	local ButtonTemplate = DrinkFrame:WaitForChild("DrinkTemplate")

	local SortedDrinkTable = DrinkFolder:GetChildren()
	table.sort(SortedDrinkTable, function(a, b)
		return a:GetAttribute("Amount") < b:GetAttribute("Amount")
	end)

	for _Index, DrinkModel in pairs(SortedDrinkTable) do
		if not DrinkModel:IsA("Tool") then
			continue
		end
		AddTemplate(DrinkModel, ButtonTemplate, DrinkFrame)
	end
end
