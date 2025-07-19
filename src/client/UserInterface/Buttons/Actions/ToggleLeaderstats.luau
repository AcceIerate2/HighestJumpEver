local Debounce = false
local TweenService = game:GetService("TweenService")
local TweenConfigurations = TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)

local SoundService = game:GetService("SoundService")
local WhooshSFX = SoundService:WaitForChild("Whoosh")
return function(Button : GuiButton, Player : Player, PlayerGui : PlayerGui)
    if not Button or not Player or not PlayerGui then return end
    if Debounce == true then return end
    Debounce = true
    local Gui = PlayerGui:WaitForChild("leaderstats"):WaitForChild("Frame")
    if Gui.Position == Gui:GetAttribute("OpenPos") then
        local Tween = TweenService:Create(Gui, TweenConfigurations, {["Position"] = Gui:GetAttribute("ClosedPos")})
        Tween:Play()
        WhooshSFX:Play()
        Tween.Completed:Wait()
        Button.Position = Button:GetAttribute("ClosedPos")
        Button:WaitForChild("ImageLabel").Rotation = 180
        Debounce = false
    elseif Gui.Position == Gui:GetAttribute("ClosedPos") then
        local Tween = TweenService:Create(Gui, TweenConfigurations, {["Position"] = Gui:GetAttribute("OpenPos")})
        Tween:Play()
        WhooshSFX:Play()
        Button.Position = Button:GetAttribute("OpenPos")
        Button:WaitForChild("ImageLabel").Rotation = 0
        Tween.Completed:Wait()
        Debounce = false
    end
    Debounce = false
end