local Cooldowns = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AnimationModule = require(ReplicatedStorage.Shared.Animations)
local DrinkModels = ReplicatedStorage.DrinkModels
return function(Player: Player): boolean
	local Key = Player.UserId :: number
	local CooldownTable = Cooldowns[Key]
	if CooldownTable then
		return false
	elseif CooldownTable == nil then
		Cooldowns[Key] = true
		local EquippedDrink = Player:FindFirstChild("EquippedDrink")
		local Model = DrinkModels:FindFirstChild(EquippedDrink.Value)
		if Model then
			local Amount = Model:GetAttribute("Amount") :: number
			local Cooldown = Model:GetAttribute("Cooldown") :: number
			if Cooldown and typeof(Cooldown) == "number" then
				local AmountToDivideBy = 1
				if Player.DoubleDrinkSpeed.Value == true then
					AmountToDivideBy = 1.4
				end
				task.delay(Player.DrinkCooldown.Value / AmountToDivideBy, function()
					Cooldowns[Key] = nil
				end)
			end
			if Amount and typeof(Amount) == "number" then
				local Power = Player:FindFirstChild("Power")
				if Power then
					local PowerMultiplier = Player:FindFirstChild("PowerMultiplier")
					local DoublePower = Player:FindFirstChild("DoublePower")
					local ExtraMultiplier = 1
					if DoublePower.Value == true then
						ExtraMultiplier = 2
					end

					local TotalAmount = Amount * ExtraMultiplier * PowerMultiplier.Value

					local PowerBoost = Player:FindFirstChild("PowerBoost")
					if PowerBoost then
						if PowerBoost.Value >= 1 then
							TotalAmount *= PowerBoost.Value
						end
					end

					Power.Value += TotalAmount

					local Character = Player.Character
					if Character then
						local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
						if HumanoidRootPart then
							local DrinkSFX = HumanoidRootPart:FindFirstChild("Drink_Custom")
							if DrinkSFX then
								DrinkSFX:Play()
							end
						end
					end

					task.spawn(AnimationModule, Player, "DrinkAnimation")

					return TotalAmount
				end
			end
		end
	end
	return false
end
