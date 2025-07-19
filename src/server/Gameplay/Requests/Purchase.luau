local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DrinksFolder = ReplicatedStorage:FindFirstChild("DrinkModels")
local HttpService = game:GetService("HttpService")
return function(Player: Player, ToolName: string)
	if not Player or not ToolName or typeof(ToolName) ~= "string" then
		return nil, "Something went wrong... try again.", Color3.fromRGB(255, 0, 0)
	end
	local Drinks = HttpService:JSONDecode(Player.Drinks.Value)
	if Drinks and typeof(Drinks) == "table" then
		local OwnsTool = table.find(Drinks, ToolName)
		if OwnsTool ~= nil then
			local EquippedDrink = Player:FindFirstChild("EquippedDrink")
			if EquippedDrink then
				if EquippedDrink.Value ~= ToolName then
					EquippedDrink.Value = ToolName
					return "Equipped", `Equipped {ToolName}`, Color3.fromRGB(135, 255, 0)
				elseif EquippedDrink.Value == ToolName then
					return "nil", "Already Equipped!", Color3.fromRGB(255, 0, 0)
				end
			end
		elseif OwnsTool == nil then
			local DataModel = DrinksFolder:FindFirstChild(ToolName)
			if DataModel then
				if
					DataModel:HasTag("RobuxDrink") == false
					and DataModel:HasTag("FreeReward") == false
					and DataModel:HasTag("SpinReward") == false
				then
					if Player.Cash.Value >= DataModel:GetAttribute("Price") then
						Player.Cash.Value -= DataModel:GetAttribute("Price")
						table.insert(Drinks, ToolName)
						Player.Drinks.Value = HttpService:JSONEncode(Drinks)
						return "Bought", "Purchased " .. ToolName, Color3.fromRGB(135, 255, 0)
					else
						return "Not Enough Cash", "Not Enough Cash!", Color3.fromRGB(255, 0, 0)
					end
				elseif DataModel:HasTag("RobuxDrink") then
					if DataModel:HasTag("FreeDrink") == false then
						return "Robux", "Check the Shop to Purchase this!", Color3.fromRGB(255, 0, 0)
					else
						return "FreeDrink", "Wait until the countdown finishes!", Color3.fromRGB(255, 0, 0)
					end
				elseif DataModel:HasTag("SpinReward") then
					return "Spin", "Get this exclusively from spins.", Color3.fromRGB(255, 0, 0)
				end
			end
		end
	end
	return nil, "Something went wrong... try again.", Color3.fromRGB(255, 0, 0)
end
