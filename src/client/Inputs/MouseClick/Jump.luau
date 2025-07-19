local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvents = ReplicatedStorage:WaitForChild("Events"):WaitForChild("RemoteEvents")
local JumpRE = RemoteEvents:WaitForChild("Jump")
return function(Player: Player, PlayerGui: PlayerGui)
	local PartsInPart = workspace:GetPartsInPart(workspace.NoJumpHitbox)
	for index, Object in pairs(PartsInPart) do
		if Object.Parent:FindFirstChildOfClass("Humanoid") then
			if Object.Parent.Name == Player.Name then
				ReplicatedStorage:WaitForChild("Events")
					:WaitForChild("BindableEvents")
					:WaitForChild("Notify")
					:Fire("You can't jump here! Go back to spawn to Jump!", Color3.fromRGB(255, 0, 0))
				return
			end
		end
	end
	JumpRE:FireServer()
end
