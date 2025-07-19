local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CashRE = ReplicatedStorage:WaitForChild("Events"):WaitForChild("RemoteEvents"):WaitForChild("Cash")
local NumberShortnerModule = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("NumberShortner"))

local function GetPosition() : UDim2
    local XPosition = math.random(0,100)/100
    local YPosition = math.random(17.5,72.5)/100
    return UDim2.fromScale(XPosition, YPosition)
end

local TweenService = game:GetService("TweenService")
local TweenConfigurations = TweenInfo.new(1, Enum.EasingStyle.Elastic)
local function GuiEffect(PlayerGui : PlayerGui, Amount : number)
    local Parent = PlayerGui:WaitForChild("DrinkEffects"):WaitForChild("Frame")
    local DrinkTemplate = Parent:WaitForChild("Template"):Clone()
    DrinkTemplate.Label.Text = `${NumberShortnerModule(Amount)}`
    DrinkTemplate.Label.TextColor3 = Color3.fromRGB(135,255,0)
    DrinkTemplate.Visible = true
    local Position = GetPosition()
    DrinkTemplate.Parent = Parent
    DrinkTemplate.Position = UDim2.fromScale(Position.X.Scale, 1.25)
    local Tween = TweenService:Create(DrinkTemplate, TweenConfigurations, {["Position"]=Position})
    Tween:Play()
    Tween.Completed:Wait()
    local FadingTween = TweenService:Create(DrinkTemplate, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {["GroupTransparency"]=1})
    FadingTween:Play()
    FadingTween.Completed:Wait()
    DrinkTemplate:Destroy()
    return
end

local SoundService = game:GetService("SoundService")
local CashSFX = SoundService:WaitForChild("Cash")
return function(Player : Player, PlayerGui : PlayerGui)
    if not Player or not PlayerGui then return end
    local Connection = CashRE.OnClientEvent:Connect(function(NewAmount : number)
        task.spawn(GuiEffect, PlayerGui, NewAmount)
        CashSFX:Play()
    end)
end