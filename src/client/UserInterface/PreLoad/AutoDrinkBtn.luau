return function(Player : Player, PlayerGui : PlayerGui)
    local Label = PlayerGui:WaitForChild("Hud"):WaitForChild("AutoDrink"):WaitForChild("Label")
    local Connection = Player:WaitForChild("AutoDrinkEnabled"):GetPropertyChangedSignal("Value"):Connect(function()
        if Player:WaitForChild("AutoDrinkEnabled").Value == true then
            Label.TextColor3 = Color3.fromRGB(0,255,0)
            Label.Text = "Auto Drink [ON]"
        elseif Player:WaitForChild("AutoDrinkEnabled").Value == false then
                        Label.TextColor3 = Color3.fromRGB(255,0,0)
            Label.Text = "Auto Drink [OFF]"
        end
    end)
end