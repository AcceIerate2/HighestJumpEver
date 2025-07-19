local function RemoveModelMass(Character : Model)
    local Humanoid = Character:FindFirstChild("Humanoid") or Character:WaitForChild("Humanoid")
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
    for index, BasePart in pairs(Character:GetDescendants()) do
        if BasePart:IsA("BasePart") then
            BasePart.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0, 1, 100)
            BasePart.Massless = false
        end
    end
end
return function(Player : Player)
    local Character = Player.Character or Player.CharacterAdded:Wait()
    RemoveModelMass(Character)
    Player.CharacterAdded:Connect(function(NewCharacter : Model)
        RemoveModelMass(NewCharacter)
    end)
end