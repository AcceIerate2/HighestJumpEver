local HttpService = game:GetService("HttpService")
return function(Player: Player): boolean
	if Player == nil then
		return false, "Something happened... try again!", Color3.fromRGB(255, 0, 0)
	end
	if Player:GetAttribute("CanClaimTimeReward") == true then
		local Decoded = HttpService:JSONDecode(Player.Drinks.Value)
		if Decoded and typeof(Decoded) == "table" then
			table.insert(Decoded, "Lightning Potion")
			Player.Drinks.Value = HttpService:JSONEncode(Decoded)
			Player:SetAttribute("CanClaimTimeReward", false)
			Player.ClaimedFreeDrink.Value = true
			return true, "Claimed!", Color3.fromRGB(0, 255, 0)
		end
		return false, "Something happened... try again!", Color3.fromRGB(255, 0, 0)
	else
		return false, "Not Yet!", Color3.fromRGB(255, 0, 0)
	end
end
