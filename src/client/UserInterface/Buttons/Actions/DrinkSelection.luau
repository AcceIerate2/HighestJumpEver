local SoundService = game:GetService("SoundService")
local Select = SoundService:WaitForChild("Select")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ViewportDisplayModule = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("ViewportDisplay"))
local NumberShortnerModule = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("NumberShortner"))
local DrinkFolder = ReplicatedStorage:WaitForChild("DrinkModels")
local TweenService = game:GetService("TweenService")
local TweenConfiguration = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, true, 0)
return function(Button: GuiButton, Player: Player, PlayerGui: PlayerGui)
	if not Button or not Player or not PlayerGui then
		return
	end
	local CanvasGroup = PlayerGui:WaitForChild("Frames")
		:WaitForChild("Shop")
		:WaitForChild("Frame")
		:WaitForChild("Drinks")
		:WaitForChild("Stats")
		:WaitForChild("Frame")
	local ViewportFrame = CanvasGroup:WaitForChild("ViewportFrame")
	local DataModel = DrinkFolder:FindFirstChild(Button.Name)
	Select:Play()
	if DataModel then
		ViewportFrame.Size = ViewportFrame:GetAttribute("Size")
		local Tween = TweenService:Create(
			ViewportFrame,
			TweenConfiguration,
			{ ["Size"] = UDim2.fromScale(ViewportFrame.Size.X.Scale * 1.15, ViewportFrame.Size.Y.Scale * 1.15) }
		)
		Tween:Play()

		for _Index, ImageLabelIfAny in pairs(ViewportFrame:GetChildren()) do
			if ImageLabelIfAny:IsA("ImageLabel") then
				if ImageLabelIfAny.Name == "Background" then
					continue
				end
				ImageLabelIfAny:Destroy()
			elseif ImageLabelIfAny:IsA("UIStroke") then
				if ImageLabelIfAny:FindFirstChild("UIGradient") then
					ImageLabelIfAny.Color = Color3.fromRGB(0, 0, 0)
					ImageLabelIfAny.UIGradient:Destroy()
				end
			elseif ImageLabelIfAny:IsA("Model") then
				ImageLabelIfAny:Destroy()
			end
		end

		if DataModel:GetAttribute("Icon") == nil then
			ViewportDisplayModule(DataModel, ViewportFrame)
		else
			local NewImageLabel = Instance.new("ImageLabel")
			NewImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
			NewImageLabel.Position = UDim2.fromScale(0.5, 0.5)
			NewImageLabel.Size = UDim2.fromScale(1, 1)
			NewImageLabel.BackgroundTransparency = 1
			NewImageLabel.Image = "rbxassetid://" .. DataModel:GetAttribute("Icon")
			NewImageLabel.Parent = ViewportFrame
		end
		ViewportFrame.Parent.Parent:WaitForChild("RobuxIcon").Visible = DataModel:HasTag("RobuxDrink")
			or DataModel:HasTag("SpinReward")
		ViewportFrame.Parent.Parent:WaitForChild("RobuxIcon2").Visible = DataModel:HasTag("RobuxDrink")
			or DataModel:HasTag("SpinReward")
		if DataModel:HasTag("RobuxDrink") == true then
			ViewportFrame:WaitForChild("Background").Visible = false
			if DataModel:HasTag("FreeDrink") then
				ViewportFrame.Parent.Parent:WaitForChild("RobuxIcon").Image = "rbxassetid://124778717324980"
				ViewportFrame.Parent.Parent:WaitForChild("RobuxIcon2").Image = "rbxassetid://124778717324980"
			else
				ViewportFrame.Parent.Parent:WaitForChild("RobuxIcon").Image = "rbxassetid://124443140465121"
				ViewportFrame.Parent.Parent:WaitForChild("RobuxIcon2").Image = "rbxassetid://124443140465121"
			end
			if DataModel:HasTag("FreeDrink") == false then
				ViewportFrame.BackgroundColor3 = Color3.fromRGB(77, 25, 99)
				SoundService:WaitForChild("Sparkles"):Play()
				ViewportFrame:WaitForChild("UIStroke").Color = Color3.fromRGB(255, 255, 255)
			end
			if DataModel:HasTag("FreeDrink") then
				ViewportFrame.Parent:WaitForChild("CashIcon"):WaitForChild("ImageLabel").Image =
					"rbxassetid://124778717324980"
			else
				ViewportFrame.Parent:WaitForChild("CashIcon"):WaitForChild("ImageLabel").Image =
					"rbxassetid://126496698154335"
			end
			if ViewportFrame.Parent.Parent:WaitForChild("BuyBtn"):FindFirstChild("UIGradient") then
				ViewportFrame.Parent.Parent:WaitForChild("BuyBtn"):FindFirstChild("UIGradient"):Destroy()
			end
			if DataModel:HasTag("FreeDrink") == false then
				ViewportFrame.Parent.Parent:WaitForChild("BuyBtn").BackgroundColor3 = Color3.fromRGB(100, 100, 100)
				local UIGradient = ReplicatedStorage:WaitForChild("UIGradient"):Clone()
				UIGradient.Parent = ViewportFrame:WaitForChild("UIStroke")
				UIGradient:Clone().Parent = ViewportFrame.Parent.Parent:WaitForChild("BuyBtn")
			end
			if DataModel:HasTag("FreeDrink") then
				ViewportFrame.Parent.Parent:WaitForChild("BuyBtn").BackgroundColor3 = Color3.fromRGB(47, 157, 0)
				ViewportFrame.BackgroundColor3 = Color3.fromRGB(82, 38, 48)
			end
		elseif DataModel:HasTag("SpinReward") == true then
			ViewportFrame.Parent.Parent:WaitForChild("RobuxIcon").Image = "rbxassetid://109816839153441"
			ViewportFrame.Parent.Parent:WaitForChild("RobuxIcon2").Image = "rbxassetid://109816839153441"
			ViewportFrame.Parent:WaitForChild("CashIcon"):WaitForChild("ImageLabel").Image =
				"rbxassetid://134845877733624"
			ViewportFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			ViewportFrame.Parent:WaitForChild("CashIcon"):WaitForChild("ImageLabel").Image =
				"rbxassetid://134845877733624"
			ViewportFrame.Parent.Parent:WaitForChild("BuyBtn").BackgroundColor3 = Color3.fromRGB(47, 157, 0)
			if ViewportFrame.Parent.Parent:WaitForChild("BuyBtn"):FindFirstChild("UIGradient") then
				ViewportFrame.Parent.Parent:WaitForChild("BuyBtn"):FindFirstChild("UIGradient"):Destroy()
			end
			ViewportFrame:WaitForChild("Background").Image = "rbxassetid://109816839153441"
			ViewportFrame:WaitForChild("Background").Visible = true
		else
			ViewportFrame:WaitForChild("Background").Visible = false
			ViewportFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			ViewportFrame.Parent:WaitForChild("CashIcon"):WaitForChild("ImageLabel").Image =
				"rbxassetid://82210977417425"
			ViewportFrame.Parent.Parent:WaitForChild("BuyBtn").BackgroundColor3 = Color3.fromRGB(47, 157, 0)
			if ViewportFrame.Parent.Parent:WaitForChild("BuyBtn"):FindFirstChild("UIGradient") then
				ViewportFrame.Parent.Parent:WaitForChild("BuyBtn"):FindFirstChild("UIGradient"):Destroy()
			end
		end
		CanvasGroup:WaitForChild("DrinkName").Text = Button.Name

		if DataModel:HasTag("RobuxDrink") or DataModel:HasTag("SpinReward") then
			CanvasGroup:WaitForChild("Price").Text = `Exclusive`
			if DataModel:HasTag("FreeDrink") then
				CanvasGroup:WaitForChild("Price").Text = "Free"
			end
		else
			CanvasGroup:WaitForChild("Price").Text = `${NumberShortnerModule(DataModel:GetAttribute("Price"))}`
		end
		CanvasGroup:WaitForChild("PowerGain").Text = `+{NumberShortnerModule(DataModel:GetAttribute("Amount"))}`

		local BuyBtn = CanvasGroup.Parent:WaitForChild("BuyBtn")
		BuyBtn:SetAttribute("Selected", Button.Name)

		local OwnsTool = string.find(Player:WaitForChild("Drinks").Value, Button.Name)
		if OwnsTool ~= nil then
			if Player:WaitForChild("EquippedDrink").Value == Button.Name then
				BuyBtn:WaitForChild("TextLabel").Text = "Equipped"
			else
				BuyBtn:WaitForChild("TextLabel").Text = "Equip"
			end
		elseif OwnsTool == nil then
			if DataModel:HasTag("RobuxDrink") == true then
				if DataModel:HasTag("FreeDrink") == true then
					BuyBtn:WaitForChild("TextLabel").Text = "Claim"
				else
					BuyBtn:WaitForChild("TextLabel").Text = "Purchase"
				end
			elseif DataModel:HasTag("SpinReward") == true then
				BuyBtn:WaitForChild("TextLabel").Text = "Locked"
			else
				BuyBtn:WaitForChild("TextLabel").Text = "Purchase"
			end
		end
	end
end
