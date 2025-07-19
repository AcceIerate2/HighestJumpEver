local ReplicatedStorage = game:GetService("ReplicatedStorage")
local NumberShortnerModule = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("NumberShortner"))

return function(Player : Player, PlayerGui : PlayerGui)
    local CanvasGroup = PlayerGui:WaitForChild("Frames"):WaitForChild("Evolutions"):WaitForChild("Frame")    
    
    local EvolutionCost = Player:WaitForChild("EvolutionCost")
    local Rebirths = Player:WaitForChild("Rebirths")

    CanvasGroup:WaitForChild("ProgressBar"):WaitForChild("Start").Text = `{NumberShortnerModule(Rebirths.Value)} Rebirths`
    CanvasGroup:WaitForChild("ProgressBar"):WaitForChild("End").Text = `{NumberShortnerModule(EvolutionCost.Value)} Rebirths`
    CanvasGroup:WaitForChild("ProgressBar"):WaitForChild("UIGradient").Offset = Vector2.new(math.clamp(Rebirths.Value/EvolutionCost.Value, 0, 1), 1)

    local Connection = Player:WaitForChild("Evolutions"):GetPropertyChangedSignal("Value"):Connect(function()
        CanvasGroup:WaitForChild("ProgressBar"):WaitForChild("Start").Text = `{NumberShortnerModule(Rebirths.Value)} Rebirths`
        CanvasGroup:WaitForChild("ProgressBar"):WaitForChild("End").Text = `{NumberShortnerModule(EvolutionCost.Value)} Rebirths`
        CanvasGroup:WaitForChild("ProgressBar"):WaitForChild("UIGradient").Offset = Vector2.new(math.clamp(Rebirths.Value/EvolutionCost.Value, 0, 1), 1)
    end)

    local RebirthConnection = Rebirths:GetPropertyChangedSignal("Value"):Connect(function()
        CanvasGroup:WaitForChild("ProgressBar"):WaitForChild("Start").Text = `{NumberShortnerModule(Rebirths.Value)} Rebirths`
        CanvasGroup:WaitForChild("ProgressBar"):WaitForChild("UIGradient").Offset = Vector2.new(math.clamp(Rebirths.Value/EvolutionCost.Value, 0, 1), 1)
    end)
end