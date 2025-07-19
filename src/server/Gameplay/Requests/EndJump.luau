local function removeVelocity(Character : Model)
    local primaryPart = Character.PrimaryPart
    primaryPart.AssemblyLinearVelocity = Vector3.zero
    primaryPart.AssemblyAngularVelocity = Vector3.zero 
end
local RepplicatedStorage = game:GetService("ReplicatedStorage")
return function(Player : Player)
    local Character = Player.Character
    if Character then
        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
        if HumanoidRootPart then
            Character:SetAttribute("JumpEnded", true)
            task.wait(0.25)
            removeVelocity(Character)
            HumanoidRootPart.CFrame = CFrame.new(6, 25, -2) 
        end
    end
end