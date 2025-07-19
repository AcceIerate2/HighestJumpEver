return function(Player: Player)
	---// Roblox Services
	local StarterGUI = game:GetService("StarterGui")
	StarterGUI:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)

	---// Deactivates the Reset Button
	repeat -- Starts the repeat loop
		local success = pcall(function()
			StarterGUI:SetCore("ResetButtonCallback", false)
		end)
		task.wait(1) -- Cooldown to avoid freezing
	until success -- Runs the loop until the Reset Button is disabled.

	StarterGUI:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
	for _Index, ModuleInstance in pairs(script:GetChildren()) do
		if ModuleInstance and ModuleInstance:IsA("ModuleScript") then
			require(ModuleInstance)(Player)
		end
	end
end
