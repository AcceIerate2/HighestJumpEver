return {
	["Power Enhancer"] = {
		["Levels"] = {
			[0] = { 10, 2, "Plus" }, -- Diamonds
			[1] = { 20, 3, "Plus" },
			[2] = { 50, 4, "Plus" },
			[3] = { 100, 5, "Plus" },
		},
		["ValueBaseName"] = "PowerMultiplier",
		["Description"] = "Doubles your Power Multiplier by 2 every time.",
		["DefaultMultiplierText"] = "1",
	},
	["Diamond Rush"] = {
		["Levels"] = {
			[0] = { 20, 2, "Plus" }, -- Diamonds
			[1] = { 60, 3, "Plus" },
			[2] = { 120, 4, "Plus" },
			[3] = { 240, 5, "Plus" },
		},
		["ValueBaseName"] = "DiamondMultiplier",
		["Description"] = "Doubles your Diamond Multiplier by 2 every time.",
		["DefaultMultiplierText"] = "1",
	},
	["Income Upgrade"] = {
		["Levels"] = {
			[0] = { 10, 2, "Plus" }, -- Diamonds
			[1] = { 20, 3, "Plus" },
			[2] = { 50, 4, "Plus" },
			[3] = { 100, 5, "Plus" },
		},
		["ValueBaseName"] = "CashMultiplier",
		["Description"] = "Doubles your Cash Multiplier by 2 every time.",
		["DefaultMultiplierText"] = "1",
	},
	["Air Charge"] = {
		["Levels"] = {
			[0] = { 10, 2, "Plus" }, -- Diamonds
			[1] = { 20, 3, "Plus" },
			[2] = { 60, 4, "Plus" },
			[3] = { 140, 5, "Plus" },
		},
		["ValueBaseName"] = "JumpPowerMultiplier",
		["Description"] = "Cuts gravity in half, boosting jump height without needing more power!",
		["DefaultMultiplierText"] = "1",
	},
	["Fast Chug"] = {
		["Levels"] = {
			[0] = { 10, 0.9, "Minus" }, -- Diamonds
			[1] = { 20, 0.7, "Minus" },
			[2] = { 100, 0.45, "Minus" },
			[3] = { 200, 0.15, "Minus" },
		},
		["ValueBaseName"] = "DrinkCooldown",
		["Description"] = "Shortens the time between sips.",
		["DefaultMultiplierText"] = "1",
	},
}
