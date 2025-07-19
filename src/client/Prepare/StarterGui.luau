local StarterGui = game:GetService("StarterGui")
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)

local function ClearTempTags()
    for Index, UiInstance in pairs(StarterGui:GetDescendants()) do
        local Tags = UiInstance:GetTags()
        for _, Tag in pairs(Tags) do
            UiInstance:RemoveTag(Tag)
        end
    end
end

local SoundService = game:GetService("SoundService")
local CoreNotificationSFX = SoundService:WaitForChild("CoreNotification")
local function SendOutNotification(Message : string)
    CoreNotificationSFX:Play()
    StarterGui:SetCore("SendNotification",{
        Title = "Server", 
        Text = "Saved Data!",
        Icon = "rbxassetid://80242830878990" 
    })
end

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvents = ReplicatedStorage:WaitForChild("Events"):WaitForChild("RemoteEvents")
local CoreNotificationRE = RemoteEvents:WaitForChild("CoreNotification")
local CoreNotificationConnection = nil
return function(Player : Player)
    CoreNotificationConnection = CoreNotificationRE.OnClientEvent:Connect(function(Message)
        SendOutNotification(Message)
    end)
end