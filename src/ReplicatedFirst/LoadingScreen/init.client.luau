script.Parent:RemoveDefaultLoadingScreen()

local PlayerService = game:GetService("Players")
local Player = PlayerService.LocalPlayer

local Gui = script:WaitForChild("LoadingScreen")
Gui.ClipToDeviceSafeArea = false
Gui.Parent = Player:WaitForChild("PlayerGui")

local TweenService = game:GetService("TweenService")
local TweenConfiguration = TweenInfo.new(0.25, Enum.EasingStyle.Bounce)

local Progress = Player:WaitForChild("LoadingScreenProgress")

local Connection = nil
Connection = Progress:GetPropertyChangedSignal("Value"):Connect(function()
	local Tween = TweenService:Create(
		Gui:WaitForChild("CanvasGroup"):WaitForChild("Frame"):WaitForChild("Bar"),
		TweenConfiguration,
		{ ["Size"] = UDim2.fromScale(math.clamp(Progress.Value, 0, 1), 1) }
	)
	Tween:Play()
	if Progress.Value >= 1 then
		Connection:Disconnect()
		Connection = nil
		Tween.Completed:Wait()
		task.wait(0.5)
		local ClosingTween =
			TweenService:Create(Gui:WaitForChild("CanvasGroup"), TweenInfo.new(0.15), { ["GroupTransparency"] = 1 })
		ClosingTween:Play()
		ClosingTween.Completed:Wait()
		Gui:Destroy()
		return
	end
end)
if Progress.Value >= 1 then
	if Progress.Value >= 1 then
		Connection:Disconnect()
		Connection = nil
		task.wait(0.5)
		local ClosingTween =
			TweenService:Create(Gui:WaitForChild("CanvasGroup"), TweenInfo.new(0.15), { ["GroupTransparency"] = 1 })
		ClosingTween:Play()
		ClosingTween.Completed:Wait()
		Gui:Destroy()
		return
	end
end
