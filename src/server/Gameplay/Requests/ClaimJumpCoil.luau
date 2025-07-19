return function(Player : Player)
    local ClaimedJumpCoil = Player:FindFirstChild("ClaimedJumpCoil")
    if ClaimedJumpCoil.Value == true then
        return false, "You already claimed this!", Color3.fromRGB(255,0,0)
    elseif ClaimedJumpCoil.Value == false then
        local JoinDate = Player:FindFirstChild("JoinDate")
        local Goal = JoinDate.Value + 86400
        if os.time() >= Goal then
            ClaimedJumpCoil.Value = true
            return true, "Claimed!", Color3.fromRGB(136, 255, 0)
        elseif os.time() < Goal then
            return false, "Not yet! Come back tomorrow to unlock this!", Color3.fromRGB(255,0,0)
        end
    end
    return false, "Something went wrong... try again!", Color3.fromRGB(255,0,0)
end