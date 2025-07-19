local EvolutionBadgeIds = {
	[1] = 2095095983985696,
	[5] = 2942769247287181,
}
local BadgeService = game:GetService("BadgeService")
local HttpService = game:GetService("HttpService")
local function ResetPlayer(Player: Player)
	for Index, SavableOBJ in pairs(Player:GetChildren()) do
		if SavableOBJ:IsA("ValueBase") and SavableOBJ:HasTag("Savable") == true then
			if SavableOBJ:HasTag("EvolutionEffected") == true then
				SavableOBJ.Value = SavableOBJ:GetAttribute("DefaultValue")
				if SavableOBJ.Name == "Drinks" then
					local DrinkInventory = HttpService:JSONDecode(SavableOBJ.Value)
					if DrinkInventory and typeof(DrinkInventory) == "table" then
						if Player.Vip.Value == true then
							table.insert(DrinkInventory, "Exclusive Potion")
						end
						if Player.StarterPack.Value == true then
							table.insert(DrinkInventory, "FireBlade Potion")
						end
						SavableOBJ.Value = HttpService:JSONEncode(DrinkInventory)
					end
				elseif SavableOBJ.Name == "RebirthCost" then
					SavableOBJ.Value = SavableOBJ.Value / Player.RebirthCostReduction.Value
				end
			end
		end
	end
	return true
end
return function(Player: Player)
	if Player == nil or typeof(Player) ~= "Instance" or not Player:IsA("Player") then
		return false, "Something went wrong... try again.", Color3.fromRGB(255, 0, 0)
	end
	local EvolutionCost = Player:FindFirstChild("EvolutionCost")
	local Rebirths = Player:FindFirstChild("Rebirths")
	local Evolutions = Player:FindFirstChild("Evolutions")
	if Rebirths.Value >= EvolutionCost.Value then
		EvolutionCost.Value *= 2
		Evolutions.Value += 1

		local BadgeToAward = EvolutionBadgeIds[Evolutions.Value]
		if BadgeToAward and typeof(BadgeToAward) == "number" then
			local Status, Response = pcall(function()
				BadgeService:AwardBadge(Player.UserId, BadgeToAward)
			end)
			if Status == false then
				warn(Response)
			end
		end

		Player.RebirthCostReduction.Value += 1
		Player.DiamondMultiplier.Value += 1
		ResetPlayer(Player)
		return true, "Success!", Color3.fromRGB(135, 255, 0)
	elseif Rebirths.Value < EvolutionCost.Value then
		return false, "Not Enough Rebirths!", Color3.fromRGB(255, 0, 0)
	end
	return false, "Something went wrong... try again.", Color3.fromRGB(255, 0, 0)
end
