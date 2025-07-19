local SoundService = game:GetService("SoundService")
local WhooshSFX = SoundService:WaitForChild("Whoosh")

local Functions = {
    ["NextPage"] = function(Button, CanvasGroup)
        local NextPageIndex = tonumber(Button.Parent.Name + 1)
        local NextPage = CanvasGroup:FindFirstChild(NextPageIndex)
        if NextPage then
            local CurrentPage = CanvasGroup:FindFirstChild(Button.Parent.Name)
            if CurrentPage then
                CurrentPage.Visible = false
                NextPage.Visible = true
                CanvasGroup:SetAttribute("Current", NextPage.Name)
                WhooshSFX:Play()
            end
        end
    end,
    ["LastPage"] = function(Button, CanvasGroup)
        local NextPageIndex = tonumber(Button.Parent.Name - 1)
        local NextPage = CanvasGroup:FindFirstChild(NextPageIndex)
        if NextPage then
            local CurrentPage = CanvasGroup:FindFirstChild(Button.Parent.Name)
            if CurrentPage then
                CurrentPage.Visible = false
                NextPage.Visible = true
                CanvasGroup:SetAttribute("Current", NextPage.Name)
                WhooshSFX:Play()
            end
        end
    end
}

return function(Button : GuiButton, Player : Player, PlayerGui : PlayerGui)
    local CanvasGroup = PlayerGui:WaitForChild("Frames"):WaitForChild("Tutorial")
    local Name = Button.Name
    local FunctionIfAny = Functions[Name]
    if FunctionIfAny then
        FunctionIfAny(Button, CanvasGroup)
    end
end