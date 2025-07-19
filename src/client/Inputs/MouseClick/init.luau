local Modules = {
	["Drink"] = require(script:WaitForChild("Drink")),
	["Jump"] = require(script:WaitForChild("Jump")),
}

return function(Player: Player)
	local Toolbar = Player:WaitForChild("Toolbar")
	local FunctionIfAny = Modules[Toolbar.Value]
	if FunctionIfAny then
		FunctionIfAny(Player, Player:WaitForChild("PlayerGui"))
	end
end
