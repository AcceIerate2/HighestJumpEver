local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PrestigeRF = ReplicatedStorage:WaitForChild("Events"):WaitForChild("RemoteFunctions"):WaitForChild("Prestige")
local NotifyBE = ReplicatedStorage:WaitForChild("Events"):WaitForChild("BindableEvents"):WaitForChild("Notify")

local SoundService = game:GetService("SoundService")
local RebirthSuccessSFX = SoundService:WaitForChild("Rebirth")
local ErrorSFX = SoundService:WaitForChild("Error") 
return function(Button : GuiButton, Player : Player, PlayerGui : PlayerGui)
    local Status, Message, TextColor = PrestigeRF:InvokeServer()
    NotifyBE:Fire(Message, TextColor)
    -- To Play SFX
    if Status == true then
        RebirthSuccessSFX:Play()
        ReplicatedStorage:WaitForChild("Events"):WaitForChild("BindableEvents"):WaitForChild("Confetti"):Fire()
    elseif Status == false then
        ErrorSFX:Play()
    end
end