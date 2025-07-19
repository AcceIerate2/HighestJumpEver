
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LeftSlipper = ReplicatedStorage.Assets.LeftSlipper
local RightSlipper = ReplicatedStorage.Assets.RightSlipper
local function EquipSlippers(Player : Player)
    local Character = Player.Character
    if Character then
        local Humanoid = Character:FindFirstChild("Humanoid")
        if Humanoid then
            Humanoid:AddAccessory(LeftSlipper:Clone())
            Humanoid:AddAccessory(RightSlipper:Clone())
            Humanoid.HipHeight += 1
        end
    end
end
return function(Player : Player)
    local ClaimedJumpCoil = Player:FindFirstChild("ClaimedJumpCoil")
    if ClaimedJumpCoil then
        if ClaimedJumpCoil.Value == true then
            EquipSlippers(Player)
            return
        end
    end
end