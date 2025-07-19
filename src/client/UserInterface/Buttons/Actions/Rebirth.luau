local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RebirthRF = ReplicatedStorage:WaitForChild("Events"):WaitForChild("RemoteFunctions"):WaitForChild("Rebirth")
local NotifyBE = ReplicatedStorage:WaitForChild("Events"):WaitForChild("BindableEvents"):WaitForChild("Notify")

local SoundService = game:GetService("SoundService")
local RebirthSuccessSFX = SoundService:WaitForChild("Rebirth")
local ErrorSFX = SoundService:WaitForChild("Error") 
return function(Button : GuiButton, Player : Player, PlayerGui : PlayerGui)
    local Status, Message, TextColor = RebirthRF:InvokeServer()
    NotifyBE:Fire(Message, TextColor)
    if Status == true then
        RebirthSuccessSFX:Play()
        ReplicatedStorage:WaitForChild("Events"):WaitForChild("BindableEvents"):WaitForChild("Confetti"):Fire()
    elseif Status == false then
        ErrorSFX:Play()
    end
end