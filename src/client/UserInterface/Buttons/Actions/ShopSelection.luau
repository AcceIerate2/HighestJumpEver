local SoundService = game:GetService("SoundService")
local SFXToPlay = SoundService:WaitForChild("Enter")
return function(Button : GuiButton, Player : Player, PlayerGui : PlayerGui)
    SFXToPlay:Play()
    local CanvasGroup = PlayerGui:WaitForChild("Frames"):WaitForChild("Shop"):WaitForChild("Frame")
    local RobuxFrame = CanvasGroup:WaitForChild("Robux")
    local DrinksFrame = CanvasGroup:WaitForChild("Drinks")
    if Button.Name == "Drinks" then
        RobuxFrame.Visible = false
        DrinksFrame.Visible = true
    elseif Button.Name == "Robux" then
        DrinksFrame.Visible = false
        RobuxFrame.Visible = true
    end
end