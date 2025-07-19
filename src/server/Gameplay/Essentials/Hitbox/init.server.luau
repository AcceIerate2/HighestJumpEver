local CollectionService = game:GetService("CollectionService")
local PlayerService = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlayerCooldowns = {}

for _index, Part in pairs(CollectionService:GetTagged("Hitbox")) do
	Part.Touched:Connect(function(OtherPart: BasePart)
		local Humanoid = OtherPart.Parent:FindFirstChildOfClass("Humanoid")
			or OtherPart.Parent.Parent:FindFirstChildOfClass("Humanoid")
		if Humanoid then
			local Player = PlayerService:GetPlayerFromCharacter(Humanoid.Parent)
			if Player and Player:IsA("Player") then
				local UserId = Player.UserId
				if table.find(PlayerCooldowns, UserId) == nil then
					table.insert(PlayerCooldowns, UserId)
					task.delay(1, function()
						local IndexToRemove = table.find(PlayerCooldowns, UserId)
						if typeof(IndexToRemove) == "number" then
							table.remove(PlayerCooldowns, IndexToRemove)
						end
					end)
					local Id = Part:GetAttribute("Id")
					local PromptType = Part:GetAttribute("PromptType")
					if Id and PromptType then
						ReplicatedStorage.Events.RemoteEvents.PromptPlayer:FireClient(Player, Id, PromptType)
					end
				end
			end
		end
	end)
end
