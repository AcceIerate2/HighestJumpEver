return function(Player : Player, PlayerGui : PlayerGui)
    local Frame = PlayerGui:WaitForChild("Frames"):WaitForChild("Shop"):WaitForChild("SectionBtns")
    PlayerGui:WaitForChild("Frames"):WaitForChild("Shop"):WaitForChild("Frame"):WaitForChild("Robux"):GetPropertyChangedSignal("Visible"):Connect(function()
        if PlayerGui:WaitForChild("Frames"):WaitForChild("Shop"):WaitForChild("Frame"):WaitForChild("Robux").Visible == true then
            Frame.Visible = true
        else
            Frame.Visible = false
        end
    end)
end