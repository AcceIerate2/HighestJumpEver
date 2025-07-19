local ReplicatedStorage = game:GetService("ReplicatedStorage")
local NumberShortnerModule = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("NumberShortner"))

local TweenService = game:GetService("TweenService")
local TweenConfiguration = TweenInfo.new(0.5, Enum.EasingStyle.Linear)

local RebirthPhaseCompleted = false
return function(Player : Player, PlayerGui : PlayerGui)
    local CanvasGroup = PlayerGui:WaitForChild("Frames"):WaitForChild("Rebirths"):WaitForChild("Frame")
    local RebirthsValue = Player:WaitForChild("Rebirths")
    local CashValue = Player:WaitForChild("Cash")
    local RebirthCost = Player:WaitForChild("RebirthCost")

    CanvasGroup:WaitForChild("ProgressBar"):WaitForChild("Start").Text = "$"..NumberShortnerModule(CashValue.Value)
    CanvasGroup:WaitForChild("ProgressBar"):WaitForChild("End").Text = "$"..NumberShortnerModule(RebirthCost.Value)
    CanvasGroup:WaitForChild("ProgressBar"):WaitForChild("UIGradient").Offset = Vector2.new(math.clamp(CashValue.Value/RebirthCost.Value, 0, 1), 1)

    local Connection = RebirthsValue:GetPropertyChangedSignal("Value"):Connect(function()
        CanvasGroup:WaitForChild("ProgressBar"):WaitForChild("Start").Text = "$"..NumberShortnerModule(CashValue.Value)
        CanvasGroup:WaitForChild("ProgressBar"):WaitForChild("End").Text = "$"..NumberShortnerModule(RebirthCost.Value)
        CanvasGroup:WaitForChild("ProgressBar"):WaitForChild("UIGradient").Offset = Vector2.new(math.clamp(CashValue.Value/RebirthCost.Value, 0, 1), 1)
        RebirthPhaseCompleted = false
    end)
    local SecondConnection = CashValue:GetPropertyChangedSignal("Value"):Connect(function()
        CanvasGroup:WaitForChild("ProgressBar"):WaitForChild("Start").Text = "$"..NumberShortnerModule(CashValue.Value)
        CanvasGroup:WaitForChild("ProgressBar"):WaitForChild("UIGradient").Offset = Vector2.new(math.clamp(CashValue.Value/RebirthCost.Value, 0, 1), 1)
        if CanvasGroup:WaitForChild("ProgressBar"):WaitForChild("UIGradient").Offset.X >= 1 then
            if RebirthPhaseCompleted == false then
                RebirthPhaseCompleted = true
                ReplicatedStorage:WaitForChild("Events"):WaitForChild("BindableEvents"):WaitForChild("Notify"):Fire("You can rebirth now!", Color3.fromRGB(218, 105, 255))
            end
        end
    end) 
end