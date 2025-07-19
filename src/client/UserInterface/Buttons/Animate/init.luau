local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local HoverSFX = SoundService:WaitForChild("Hover")
local TweenConfiguration = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)

local function Hover(Button: GuiButton)
	HoverSFX:Play()
	local Tween = TweenService:Create(
		Button,
		TweenConfiguration,
		{ ["Size"] = UDim2.fromScale(Button.Size.X.Scale * 1.05, Button.Size.Y.Scale * 1.05) }
	)
	Tween:Play()
	local ChildIcon = Button:FindFirstChildOfClass("ImageLabel")
	if ChildIcon then
		ChildIcon.ImageColor3 = Color3.fromRGB(116, 116, 116)
	end
end

local function Reset(Button: GuiButton)
	local Tween = TweenService:Create(Button, TweenConfiguration, { ["Size"] = Button:GetAttribute("DefaultSize") })
	Tween:Play()
	local ChildIcon = Button:FindFirstChildOfClass("ImageLabel")
	if ChildIcon then
		ChildIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
	end
end

local function Hold(Button: GuiButton)
	local Tween = TweenService:Create(
		Button,
		TweenConfiguration,
		{ ["Size"] = UDim2.fromScale(Button.Size.X.Scale / 1.25, Button.Size.Y.Scale / 1.25) }
	)
	Tween:Play()
	local ChildIcon = Button:FindFirstChildOfClass("ImageLabel")
	if ChildIcon then
		ChildIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
	end
end

local function Press(Button: GuiButton)
	local Tween = TweenService:Create(Button, TweenConfiguration, { ["Size"] = Button:GetAttribute("DefaultSize") })
	Tween:Play()
	local ChildIcon = Button:FindFirstChildOfClass("ImageLabel")
	if ChildIcon then
		ChildIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
	end
end

return function(Button: GuiButton)
	if not Button:IsA("GuiButton") then
		return
	end
	Button:SetAttribute("DefaultSize", Button.Size)
	Button.MouseEnter:Connect(function()
		if Button:HasTag("Inactive") == true then
			return
		end
		Hover(Button)
	end)
	Button.MouseLeave:Connect(function()
		if Button:HasTag("Inactive") == true then
			return
		end
		Reset(Button)
	end)
	Button.MouseButton1Down:Connect(function()
		if Button:HasTag("Inactive") == true then
			return
		end
		Hold(Button)
	end)
	Button.MouseButton1Up:Connect(function()
		if Button:HasTag("Inactive") == true then
			return
		end
		Press(Button)
	end)
end
