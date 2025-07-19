local Duration = 720
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return function(Player : Player)
    if not Player then return end
    task.spawn(function()
        for Index = Duration, 0, -1 do
            local SkippedCountdown = Player:GetAttribute("GiftSkipped")
            if SkippedCountdown and typeof(SkippedCountdown) == "boolean" and SkippedCountdown == true then
                ReplicatedStorage.Events.RemoteEvents.UpdateTimer:FireClient(Player, 0)
                break
            end
            ReplicatedStorage.Events.RemoteEvents.UpdateTimer:FireClient(Player, Index)
            task.wait(1)
        end
        Player:SetAttribute("CanClaimTimeReward", true)
        return
    end)
end