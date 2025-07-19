local DrinkModule =
	require(script.Parent.Parent:WaitForChild("Inputs"):WaitForChild("MouseClick"):WaitForChild("Drink"))

local CurrentThread = nil

return function(Player: Player)
	local AutoDrinkEnabled = Player:WaitForChild("AutoDrinkEnabled")
	local Connection = AutoDrinkEnabled:GetPropertyChangedSignal("Value"):Connect(function()
		if CurrentThread and typeof(CurrentThread) == "thread" then
			task.cancel(CurrentThread)
			CurrentThread = nil
		end
		if AutoDrinkEnabled.Value == true then
			CurrentThread = task.spawn(function()
				while Player:WaitForChild("AutoDrinkEnabled").Value == true do
					DrinkModule(Player, Player.PlayerGui)
					task.wait(Player:WaitForChild("DrinkCooldown").Value)
				end
				return
			end)
		end
	end)
end
