local RebirthBadgeIds = {
	[5] = 2292540937904885,
	[25] = 2583825673732806,
}

local BadgeService = game:GetService("BadgeService")
local HttpService = game:GetService("HttpService")

return function(Player: Player)
	if Player == nil or typeof(Player) ~= "Instance" and not Player:IsA("Player") then
		return false, "Something went wrong... try again!", Color3.fromRGB(255, 0, 0)
	end
	local Rebirths = Player:FindFirstChild("Rebirths")
	local PowerMultiplier = Player:FindFirstChild("PowerMultiplier")
	local Cash = Player:FindFirstChild("Cash")
	local RebirthCost = Player:FindFirstChild("RebirthCost")
	if Rebirths and PowerMultiplier and Cash then
		if Cash.Value >= RebirthCost.Value then
			Cash.Value = 0
			Player.Power.Value = 0
			Player.Drinks.Value = `["Default"]`
			local DrinkInventory = HttpService:JSONDecode(Player.Drinks.Value)
			if DrinkInventory and typeof(DrinkInventory) == "table" then
				if Player.StarterPack.Value == true then
					table.insert(DrinkInventory, "FireBlade Potion")
				end
				if Player.Vip.Value == true then
					table.insert(DrinkInventory, "Exclusive Potion")
				end
				if Player.ClaimedFreeDrink.Value == true then
					table.insert(DrinkInventory, "Lightning Potion")
				end
				if Player.CoconutDrink.Value == true then
					table.insert(DrinkInventory, "Coconut Drink")
				end
				Player.Drinks.Value = HttpService:JSONEncode(DrinkInventory)
			end

			Player.EquippedDrink.Value = "Default"

			local DoubleDiamonds = Player:FindFirstChild("DoubleDiamonds")
			local ExtraMultiplier = 1
			if DoubleDiamonds.Value == true then
				ExtraMultiplier = 2
			end
			Player.Diamonds.Value += 10 * Player.DiamondMultiplier.Value * ExtraMultiplier
			Player.PowerMultiplier.Value += 1
			RebirthCost.Value = (RebirthCost.Value * 15.1) / Player.RebirthCostReduction.Value
			Rebirths.Value += 1

			local BadgeToAward = RebirthBadgeIds[Rebirths.Value]
			if BadgeToAward and typeof(BadgeToAward) == "number" then
				local Status, Response = pcall(function()
					BadgeService:AwardBadge(Player.UserId, BadgeToAward)
				end)
				if Status == false then
					warn(Response)
				end
			end

			return true, "Success!", Color3.fromRGB(135, 255, 0)
		elseif Cash.Value < RebirthCost.Value then
			return false, "Not Enough Cash!", Color3.fromRGB(255, 0, 0)
		end
	end
	return false, "Something went wrong... try again!", Color3.fromRGB(255, 0, 0)
end
