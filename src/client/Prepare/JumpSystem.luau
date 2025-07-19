local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local function Empty()
end
return function(Player : Player)
    ContextActionService:BindAction("jumpAction", Empty, false)
    UserInputService.JumpRequest:Connect(function()
        ContextActionService:BindAction("jumpAction", Empty, false)
        local Character = Player.Character 
        if not Character then 
            Character = Player.CharacterAdded:Wait() 
        end
        local Humanoid = Character:WaitForChild("Humanoid")
        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
        --Humanoid.JumpHeight = 0
        if Humanoid.FloorMaterial ~= Enum.Material.Air then
            --HumanoidRootPart.Velocity = Vector3.new(HumanoidRootPart.Velocity.X, Player.Power.Value/1.25 * Player:WaitForChild("JumpPowerMultiplier").Value,HumanoidRootPart.Velocity.Z)
        end
    end)
end
