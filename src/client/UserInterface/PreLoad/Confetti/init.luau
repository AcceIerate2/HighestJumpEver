local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local ConfettiSFX = SoundService:WaitForChild("Confetti")

local RandomColors = {
	Color3.fromRGB(255, 0, 0),
	Color3.fromRGB(255, 234, 0),
	Color3.fromRGB(0, 208, 255),
	Color3.fromRGB(13, 255, 0),
	Color3.fromRGB(234, 0, 255),
}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ConfettiBE = ReplicatedStorage:WaitForChild("Events"):WaitForChild("BindableEvents"):WaitForChild("Confetti")
local ConfettiRE = ReplicatedStorage:WaitForChild("Events"):WaitForChild("RemoteEvents"):WaitForChild("Confetti")
local function DisplayConfetti(ConfettiTemplate: Frame)
	ConfettiSFX:Play()
	for _Index = 150, 1, -1 do
		task.spawn(function()
			task.wait(math.random(1, 2) / 100)
			local Cloned = ConfettiTemplate:Clone()
			if Cloned then
				local XAxis = math.random(1, 100) / 100
				local YAxis = math.random(1.2, 50) / 100
				Cloned.Position = UDim2.fromScale(XAxis, 1)
				local ToDivideBy = math.random(1, 3)
				Cloned.Size = UDim2.fromScale(Cloned.Size.X.Scale / ToDivideBy, Cloned.Size.Y.Scale / ToDivideBy)
				Cloned.Rotation = math.random(0, 359)
				Cloned.Parent = ConfettiTemplate.Parent
				Cloned.BackgroundColor3 = RandomColors[math.random(1, #RandomColors)]
				Cloned.Visible = true
				local Tween = TweenService:Create(
					Cloned,
					TweenInfo.new(
						math.random(25, 75) / 100,
						Enum.EasingStyle.Circular,
						Enum.EasingDirection.Out,
						0,
						true,
						0
					),
					{ ["Position"] = UDim2.fromScale(XAxis, YAxis) }
				)
				Tween:Play()
				Tween.Completed:Wait()
				Cloned:Destroy()
			end
		end)
	end
end

return function(_Player: Player, PlayerGui: PlayerGui)
	local ConfettiTemplate = PlayerGui:WaitForChild("Confetti"):WaitForChild("Template")
	--[[SoundService:WaitForChild("Reward"):GetPropertyChangedSignal("TimePosition"):Connect(function()
        if SoundService:WaitForChild("Reward").TimePosition < 0.125 then 
            DisplayConfetti(ConfettiTemplate) 
        end
    end)]]
	ConfettiRE.OnClientEvent:Connect(function()
		DisplayConfetti(ConfettiTemplate)
	end)
	ConfettiBE.Event:Connect(function()
		DisplayConfetti(ConfettiTemplate)
	end)
end
