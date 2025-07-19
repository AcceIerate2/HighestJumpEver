local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SharedFolder = ReplicatedStorage.Shared
local InstanceCreatorModule = require(SharedFolder.InstanceCreator)
local function main(Parent: Instance): boolean
	local Cash = InstanceCreatorModule("NumberValue", "Cash", Parent)
	Cash:AddTag("Savable")
	Cash:AddTag("EvolutionEffected")
	Cash:SetAttribute("DefaultValue", 0)

	local CashMultiplier = InstanceCreatorModule("NumberValue", "CashMultiplier", Parent)
	CashMultiplier:AddTag("Savable")
	CashMultiplier.Value = 1
	CashMultiplier:AddTag("EvolutionEffected")
	CashMultiplier:SetAttribute("DefaultValue", 1)

	local Spins = InstanceCreatorModule("NumberValue", "Spins", Parent)
	Spins:AddTag("Savable")
	Spins.Value = 1

	local SpinGoal = InstanceCreatorModule("NumberValue", "SpinGoal", Parent)
	SpinGoal:AddTag("Savable")
	SpinGoal.Value = os.time() + 5

	local Power = InstanceCreatorModule("NumberValue", "Power", Parent)
	Power:AddTag("Savable")
	Power:AddTag("EvolutionEffected")
	Power:SetAttribute("DefaultValue", 0)

	local PowerMultiplier = InstanceCreatorModule("NumberValue", "PowerMultiplier", Parent)
	PowerMultiplier.Value = 1
	PowerMultiplier:AddTag("Savable")
	PowerMultiplier:AddTag("EvolutionEffected")
	PowerMultiplier:SetAttribute("DefaultValue", 1)

	local PowerBoost = InstanceCreatorModule("NumberValue", "PowerBoost", Parent)
	PowerBoost.Value = 0
	PowerBoost:SetAttribute("DefaultValue", 0)

	local Rebirths = InstanceCreatorModule("NumberValue", "Rebirths", Parent)
	Rebirths:AddTag("Savable")
	Rebirths:AddTag("EvolutionEffected")
	Rebirths:SetAttribute("DefaultValue", 0)

	local RebirthCost = InstanceCreatorModule("NumberValue", "RebirthCost", Parent)
	RebirthCost.Value = 12350
	RebirthCost:AddTag("Savable")
	RebirthCost:AddTag("EvolutionEffected")
	RebirthCost:SetAttribute("DefaultValue", 12350)

	local DrinkInventory = InstanceCreatorModule("StringValue", "Drinks", Parent)
	DrinkInventory:AddTag("Savable")
	DrinkInventory.Value = `["Default"]`
	DrinkInventory:AddTag("EvolutionEffected")
	DrinkInventory:SetAttribute("DefaultValue", `["Default"]`)

	local EquippedDrink = InstanceCreatorModule("StringValue", "EquippedDrink", Parent)
	EquippedDrink:AddTag("Savable")
	EquippedDrink.Value = "Default"
	EquippedDrink:AddTag("EvolutionEffected")
	EquippedDrink:SetAttribute("DefaultValue", "Default")

	local Diamonds = InstanceCreatorModule("NumberValue", "Diamonds", Parent)
	Diamonds:AddTag("Savable")

	local DiamondMultiplier = InstanceCreatorModule("IntValue", "DiamondMultiplier", Parent)
	DiamondMultiplier.Value = 1
	DiamondMultiplier:AddTag("Savable")
	DiamondMultiplier:SetAttribute("DefaultValue", 1)

	local DrinkCooldown = InstanceCreatorModule("NumberValue", "DrinkCooldown", Parent)
	DrinkCooldown.Value = 1
	DrinkCooldown:AddTag("Savable")
	DrinkCooldown:AddTag("EvolutionEffected")
	DrinkCooldown:SetAttribute("DefaultValue", 1)

	local HighestJump = InstanceCreatorModule("NumberValue", "HighestJump", Parent)
	HighestJump:AddTag("Savable")
	HighestJump:AddTag("EvolutionEffected")
	HighestJump:SetAttribute("DefaultValue", 0)

	local Tokens = InstanceCreatorModule("IntValue", "Tokens", Parent)
	Tokens:AddTag("Savable")

	local Evolutions = InstanceCreatorModule("IntValue", "Evolutions", Parent)
	Evolutions:AddTag("Savable")

	local EvolutionCost = InstanceCreatorModule("IntValue", "EvolutionCost", Parent)
	EvolutionCost.Value = 7
	EvolutionCost:AddTag("Savable")

	local UpgradeData = InstanceCreatorModule("StringValue", "UpgradeData", Parent)
	UpgradeData.Value = '{"Power Enhancer":0, "Diamond Rush":0, "Income Upgrade": 0, "Air Charge": 0, "Fast Chug": 0}'
	UpgradeData:AddTag("Savable")
	UpgradeData:AddTag("EvolutionEffected")
	UpgradeData:SetAttribute(
		"DefaultValue",
		'{"Power Enhancer":0, "Diamond Rush":0, "Income Upgrade": 0, "Air Charge": 0, "Fast Chug": 0}'
	)

	local JumpPowerMultiplier = InstanceCreatorModule("NumberValue", "JumpPowerMultiplier", Parent)
	JumpPowerMultiplier.Value = 1
	JumpPowerMultiplier:AddTag("Savable")
	JumpPowerMultiplier:AddTag("EvolutionEffected")
	JumpPowerMultiplier:SetAttribute("DefaultValue", 1)

	local ClaimedJumpCoil = InstanceCreatorModule("BoolValue", "ClaimedJumpCoil", Parent)
	ClaimedJumpCoil:AddTag("Savable")

	local JoinDate = InstanceCreatorModule("NumberValue", "JoinDate", Parent)
	JoinDate:AddTag("Savable")

	local LastDisconnect = InstanceCreatorModule("NumberValue", "LastDisconnect", Parent)
	LastDisconnect:AddTag("Savable")

	local LastUnlockedReward = InstanceCreatorModule("NumberValue", "LastUnlockedReward", Parent)
	LastUnlockedReward.Value = 0
	LastUnlockedReward:AddTag("Savable")

	local DailyRewardGoal = InstanceCreatorModule("NumberValue", "DailyRewardGoal", Parent)
	DailyRewardGoal:AddTag("Savable")

	local RebirthCostReduction = InstanceCreatorModule("NumberValue", "RebirthCostReduction", Parent)
	RebirthCostReduction.Value = 1
	RebirthCostReduction:AddTag("Savable")

	InstanceCreatorModule("NumberValue", "CurrentJump", Parent)
	InstanceCreatorModule("NumberValue", "CurrentAltitude", Parent)
	InstanceCreatorModule("StringValue", "Toolbar", Parent)
	InstanceCreatorModule("BoolValue", "IsJumping", Parent)
	InstanceCreatorModule("StringValue", "SkyName", Parent)
	InstanceCreatorModule("NumberValue", "BeginValue", Parent)
	InstanceCreatorModule("NumberValue", "EndValue", Parent)
	InstanceCreatorModule("CFrameValue", "RootCFrame", Parent)
	InstanceCreatorModule("BoolValue", "DoubleCash", Parent)
	InstanceCreatorModule("BoolValue", "DoublePower", Parent)
	InstanceCreatorModule("BoolValue", "DoubleDiamonds", Parent)
	InstanceCreatorModule("BoolValue", "AutoDrink", Parent)
	InstanceCreatorModule("BoolValue", "AutoDrinkEnabled", Parent)
	InstanceCreatorModule("BoolValue", "StarterPack", Parent):AddTag("Savable")
	InstanceCreatorModule("BoolValue", "Vip", Parent):AddTag("Savable")
	InstanceCreatorModule("BoolValue", "DoubleOfflineGains", Parent):AddTag("Savable")
	InstanceCreatorModule("BoolValue", "DoubleDrinkSpeed", Parent):AddTag("Savable")
	InstanceCreatorModule("BoolValue", "ClaimedFreeDrink", Parent):AddTag("Savable")
	InstanceCreatorModule("BoolValue", "CoconutDrink", Parent):AddTag("Savable")
	return true
end
return function(Player: Player): boolean
	if not Player then
		return false
	end
	return main(Player) :: boolean
end
