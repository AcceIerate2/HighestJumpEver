local PreLoadModule = require(script:WaitForChild("PreLoad"))
local ButtonsModule = require(script:WaitForChild("Buttons"))
return function(Player: Player)
	local PlayerGui = Player:WaitForChild("PlayerGui")
	PreLoadModule(Player, PlayerGui)
	ButtonsModule(Player, PlayerGui)
end
