local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DrinkModels = ReplicatedStorage:FindFirstChild("DrinkModels")
return function(Player : Player, ToolName : string)
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local Humanoid = Character:FindFirstChild("Humanoid")
    if Humanoid then
        if ToolName == "Drink" then
            local EquippedDrink = Player:FindFirstChild("EquippedDrink")
            if EquippedDrink then
                local ToolIfAny = DrinkModels:FindFirstChild(EquippedDrink.Value)
                if ToolIfAny and ToolIfAny:IsA("Tool") then
                    local Tool = ToolIfAny:Clone()
                    if Tool then
                        Humanoid:UnequipTools()
                        Player.Backpack:ClearAllChildren()
                        Tool.Parent = Player.Backpack
                        Humanoid:EquipTool(Tool)
                    end
                end
            end
        else
            Humanoid:UnequipTools()
            Player.Backpack:ClearAllChildren()
        end
    end
end