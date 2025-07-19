local ReplicatedStorage = game:GetService("ReplicatedStorage")
local NumberShortner = require(ReplicatedStorage.Shared.NumberShortner)
local _Connection = nil
return function(Player: Player, PlayerGui: PlayerGui)
	if not Player or not PlayerGui then
		return
	end
	local PowerBoostFrame = PlayerGui:WaitForChild("Boosts"):WaitForChild("Frame"):WaitForChild("Power")
	local PowerBoost = Player:FindFirstChild("PowerBoost")
	if PowerBoost then
		_Connection = PowerBoost:GetPropertyChangedSignal("Value"):Connect(function()
			if PowerBoost.Value >= 2 then
				PowerBoostFrame:WaitForChild("Label").Text = `x{NumberShortner(PowerBoost.Value)}`
				PowerBoostFrame.Visible = true
			else
				PowerBoostFrame.Visible = false
			end
		end)
	end
end
