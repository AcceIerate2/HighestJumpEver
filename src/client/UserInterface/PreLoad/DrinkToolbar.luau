local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DrinkModels = ReplicatedStorage:WaitForChild("DrinkModels")
local ViewportDisplayModule = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("ViewportDisplay"))
return function(Player : Player, PlayerGui : PlayerGui)
    local ToolbarGui = PlayerGui:WaitForChild("Toolbar"):WaitForChild("Frame")
    local DrinkViewport = ToolbarGui:WaitForChild("Drink"):WaitForChild("ViewportFrame")
    local Connection = Player:WaitForChild("EquippedDrink"):GetPropertyChangedSignal("Value"):Connect(function()
        local DataModel = DrinkModels:FindFirstChild(Player:WaitForChild("EquippedDrink").Value)
        if DataModel then
            ViewportDisplayModule(DataModel, DrinkViewport)
        end
    end)
end