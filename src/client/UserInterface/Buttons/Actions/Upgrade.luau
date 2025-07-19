local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UpgradeRF = ReplicatedStorage:WaitForChild("Events"):WaitForChild("RemoteFunctions"):WaitForChild("Upgrade")
local NotifyBE = ReplicatedStorage:WaitForChild("Events"):WaitForChild("BindableEvents"):WaitForChild("Notify")

local UpgradeSelectionModule = require(script.Parent:WaitForChild("UpgradeSelection"))
local SoundService = game:GetService("SoundService")
return function(Button : GuiButton, Player : Player, PlayerGui : PlayerGui)
    local Status, Message, TextColor = UpgradeRF:InvokeServer(Button:GetAttribute("SelectedUpgrade"))
    NotifyBE:Fire(Message, TextColor)
    -- To Play SFX
    if Status == true then
        UpgradeSelectionModule(Button:GetAttribute("SelectedUpgrade"), Player, PlayerGui)
        ReplicatedStorage:WaitForChild("Events"):WaitForChild("BindableEvents"):WaitForChild("Confetti"):Fire()
    elseif Status == false then
    end
end