local UserInputService = game:GetService("UserInputService")
return function(Player: Player, PlayerGui: PlayerGui)
	--[[if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and not UserInputService.MouseEnabled then
        task.spawn(function()
            PlayerGui:WaitForChild("TouchGui"):WaitForChild("TouchControlFrame"):WaitForChild("JumpButton"):Destroy()
        end)
    end]]
	for Index, Module in pairs(script:GetChildren()) do
		require(Module)(Player, PlayerGui)
	end
end
