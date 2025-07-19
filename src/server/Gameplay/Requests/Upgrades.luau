local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Upgrades = require(ReplicatedStorage.UpgradeData)

local HttpService = game:GetService("HttpService")
return function(Player: Player, Name: string)
	if Name == nil or typeof(Name) ~= "string" then
		return false, "Something went wrong... try again.", Color3.fromRGB(255, 0, 0)
	end
	local UpgradeData = Upgrades[Name]
	if UpgradeData then
		local PlayerUpgradeData = HttpService:JSONDecode(Player.UpgradeData.Value)
		local UpgradeLevel = PlayerUpgradeData[Name]
		if UpgradeLevel > 3 then
			return false, "Max!", Color3.fromRGB(255, 0, 0)
		end

		local Cost = UpgradeData["Levels"][UpgradeLevel][1]

		if Player.Diamonds.Value >= Cost then
			local ValueOBJ = Player:FindFirstChild(UpgradeData["ValueBaseName"])
			if ValueOBJ then
				if UpgradeData["Levels"][UpgradeLevel][3] == "Plus" then
					ValueOBJ.Value += 1
				else
					if ValueOBJ.Name == "DrinkCooldown" then
						ValueOBJ.Value -= (ValueOBJ.Value - UpgradeData["Levels"][UpgradeLevel][2])
					else
						ValueOBJ.Value -= 1 - UpgradeData["Levels"][UpgradeLevel][2]
					end
				end
				Player.Diamonds.Value -= Cost

				PlayerUpgradeData[Name] = UpgradeLevel + 1
				Player.UpgradeData.Value = HttpService:JSONEncode(PlayerUpgradeData)

				return true, "Success!", Color3.fromRGB(135, 255, 0)
			else
				return false, "Something went wrong... try again.", Color3.fromRGB(255, 0, 0)
			end
		elseif Player.Diamonds.Value < Cost then
			return false, "Not Enough Diamonds", Color3.fromRGB(255, 0, 0)
		end
	end
end
