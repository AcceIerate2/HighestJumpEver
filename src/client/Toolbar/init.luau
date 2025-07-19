local ToolRE = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("RemoteEvents"):WaitForChild("Tool")
local PlayerService = game:GetService("Players")
local Player = PlayerService.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local ToolbarGui = PlayerGui:WaitForChild("Toolbar")
local Frame = ToolbarGui:WaitForChild("Frame")
local function ToggleButton(Button : GuiButton, Toggle : boolean)
    local UiStroke = Button:FindFirstChild("UIStroke")
    if UiStroke then
        UiStroke.Enabled = Toggle
    end
end
local SoundService = game:GetService("SoundService")
local ToolbarSFX = SoundService:WaitForChild("Toolbar")
local Cooldown = false
local function Switch(ToolName)
    local Button = Frame:FindFirstChild(ToolName)
    ToolbarSFX:Play()
    for Index, OtherBtn in pairs(Frame:GetChildren()) do
        if OtherBtn == Button then
            ToggleButton(OtherBtn, true)
        else
            ToggleButton(OtherBtn, false)
        end
    end
end
local Toolbar = Player:WaitForChild("Toolbar")
return function(ToolName)
    if Cooldown == true then return end
    Cooldown = true
    if Toolbar.Value == ToolName then
        ToolRE:FireServer("")
        local Button = Frame:WaitForChild(Toolbar.Value, 3)
        if Button then
            ToggleButton(Button, false)
            Toolbar.Value = ""
        end
        Cooldown = false
        return
    end
    ToolRE:FireServer(ToolName)
    Toolbar.Value = ToolName    
    Switch(ToolName)
    Cooldown = false
end