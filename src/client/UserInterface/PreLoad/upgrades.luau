local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UpgradeCosts = require(ReplicatedStorage:WaitForChild("UpgradeData"))
local HttpService = game:GetService("HttpService")

local function Update(Player, CanvasGroup)
    local PlayerUpgradeData = HttpService:JSONDecode(Player:WaitForChild("UpgradeData").Value)
    for Index, UpgradeSelectionBtn in pairs(CanvasGroup:WaitForChild("Frame"):WaitForChild("ScrollingFrame"):GetChildren()) do
        if not UpgradeSelectionBtn:IsA("GuiButton") then continue end
        local Name = UpgradeSelectionBtn.Name
        local CurrentLevel = PlayerUpgradeData[Name]
        UpgradeSelectionBtn:WaitForChild("Frame"):WaitForChild("UIGradient").Offset = Vector2.new(math.clamp(CurrentLevel/4,0,1), 1)
    end
end

return function(Player : Player, PlayerGui : PlayerGui)
    local CanvasGroup = PlayerGui:WaitForChild("Frames"):WaitForChild("Upgrades"):WaitForChild("Frame")
    Update(Player, CanvasGroup)
    local Connection = Player:WaitForChild("UpgradeData"):GetPropertyChangedSignal("Value"):Connect(function()
        Update(Player, CanvasGroup)
    end)
end