local ReplicatedStorage = game:GetService("ReplicatedStorage")
local NumberShortnerModule = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("NumberShortner"))
return function(Player : Player, PlayerGui : PlayerGui)
    local Hud = PlayerGui:WaitForChild("Hud")
    local Left = Hud:WaitForChild("Frame"):WaitForChild("Left")
    local Right = Hud:WaitForChild("Frame"):WaitForChild("Right")
    local Top = Hud:WaitForChild("Frame"):WaitForChild("Top")

    local Cash = Player:WaitForChild("Cash")
    local Power = Player:WaitForChild("Power")
    local Rebirths = Player:WaitForChild("Rebirths")
    local Diamonds = Player:WaitForChild("Diamonds")
    local CurrentJump = Player:WaitForChild("CurrentJump")
    local HighestJump = Player:WaitForChild("HighestJump")
    local CurrentAltitude = Player:WaitForChild("CurrentAltitude")
    local BeginValue = Player:WaitForChild("BeginValue")
    local EndValue = Player:WaitForChild("EndValue")

    local CashLabel = Top:WaitForChild("TopPart"):WaitForChild("Cash"):WaitForChild("Label")
    local PowerLabel = Top:WaitForChild("TopPart"):WaitForChild("Power"):WaitForChild("Label")
    local RebirthsLabel = Right:WaitForChild("Btns"):WaitForChild("Rebirths"):WaitForChild("ImageLabel"):WaitForChild("Label")
    local DiamondsLabel = Right:WaitForChild("Diamonds"):WaitForChild("Label")
    local CurrentJumpLabel = Hud:WaitForChild("BottomPart"):WaitForChild("Frame"):WaitForChild("CurrentJump"):WaitForChild("Label")
    local HighestJumpLabel = Hud:WaitForChild("BottomPart"):WaitForChild("Frame"):WaitForChild("HighestJump"):WaitForChild("Label")
    local CurrentAltitudeLabel = Hud:WaitForChild("BottomPart"):WaitForChild("Frame"):WaitForChild("CurrentAltitude"):WaitForChild("Label")

    CashLabel.Text = NumberShortnerModule(Cash.Value)
    PowerLabel.Text = NumberShortnerModule(Power.Value)
    RebirthsLabel.Text = NumberShortnerModule(Rebirths.Value)
    DiamondsLabel.Text = NumberShortnerModule(Diamonds.Value)
    CurrentJumpLabel.Text = NumberShortnerModule(CurrentJump.Value).." m"
    HighestJumpLabel.Text = NumberShortnerModule(HighestJump.Value).." m"
    CurrentAltitudeLabel.Text = NumberShortnerModule(CurrentAltitude.Value).." m"

    Cash:GetPropertyChangedSignal("Value"):Connect(function()
        CashLabel.Text = NumberShortnerModule(Cash.Value)
    end)

    Power:GetPropertyChangedSignal("Value"):Connect(function()
        PowerLabel.Text = NumberShortnerModule(Power.Value)
    end)

    Rebirths:GetPropertyChangedSignal("Value"):Connect(function()
        RebirthsLabel.Text = NumberShortnerModule(Rebirths.Value)
    end)

    Diamonds:GetPropertyChangedSignal("Value"):Connect(function()
        DiamondsLabel.Text = NumberShortnerModule(Diamonds.Value)
    end)

    CurrentJump:GetPropertyChangedSignal("Value"):Connect(function()
        CurrentJumpLabel.Text = NumberShortnerModule(CurrentJump.Value).." m"
    end)

    HighestJump:GetPropertyChangedSignal("Value"):Connect(function()
        HighestJumpLabel.Text = NumberShortnerModule(HighestJump.Value).." m"
    end)

    local Bar = Left:WaitForChild("TopPart"):WaitForChild("Progress")
    CurrentAltitude:GetPropertyChangedSignal("Value"):Connect(function()
        CurrentAltitudeLabel.Text = NumberShortnerModule(CurrentAltitude.Value).." m"
        local progress = (CurrentAltitude.Value - BeginValue.Value) / (EndValue.Value - BeginValue.Value)
        progress = math.clamp(progress, 0, 1) 
        Bar:WaitForChild("UIGradient").Offset = Vector2.new(1,-progress)
    end)
end