local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvent = ReplicatedStorage:WaitForChild("Events"):WaitForChild("RemoteEvents"):WaitForChild("RemoveVelocity")

local PlayerService = game:GetService("Players")
local Player = PlayerService.LocalPlayer

local function removeVelocity(Character : Model)
    for index, BasePart in pairs(Character:GetDescendants()) do
        if BasePart:IsA("BasePart") then
            BasePart.AssemblyLinearVelocity = Vector3.zero
            BasePart.AssemblyAngularVelocity = Vector3.zero
            BasePart.Velocity = Vector3.zero
        end
    end
end

RemoteEvent.OnClientEvent:Connect(function()
    local Character = Player.Character
    if Character and typeof(Character) == "Instance" and Character:IsA("Model") then
        removeVelocity(Character)
    end
end)