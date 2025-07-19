local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvents = ReplicatedStorage:WaitForChild("Events"):WaitForChild("RemoteEvents")
local EndJumpRE = RemoteEvents:WaitForChild("EndJump")
return function(Button : GuiButton, Player : Player, PlayerGui : PlayerGui)
    EndJumpRE:FireServer()
end