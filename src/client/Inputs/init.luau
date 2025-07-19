local UserInputService = game:GetService("UserInputService")
local ToolbarModule = require(script.Parent:WaitForChild("Toolbar"))
local LeaderboardTogglerModule = require(
	script.Parent
		:WaitForChild("UserInterface")
		:WaitForChild("Buttons")
		:WaitForChild("Actions")
		:WaitForChild("ToggleLeaderstats")
)
local Inputs = {
	[Enum.KeyCode.One.Name] = function(Player: Player)
		ToolbarModule("Jump")
	end,
	[Enum.KeyCode.Two.Name] = function(Player: Player)
		ToolbarModule("Drink")
	end,
	[Enum.KeyCode.Tab.Name] = function(Player: Player)
		local PlayerGui = Player.PlayerGui
		if PlayerGui then
			LeaderboardTogglerModule(
				PlayerGui:WaitForChild("leaderstats"):WaitForChild("Frame"):WaitForChild("ToggleLeaderstats"),
				Player,
				Player.PlayerGui
			)
		end
	end,
}
local MouseClickModule = require(script:WaitForChild("MouseClick"))
local PlayerService = game:GetService("Players")
local Player = PlayerService.LocalPlayer
local Mouse = Player:GetMouse()
local _Connection = nil
local _MouseConnection = nil
return function()
	_Connection = UserInputService.InputBegan:Connect(function(Input, Gpe: boolean)
		if Gpe == true then
			return
		end
		local IsValidInput = Inputs[Input.KeyCode.Name]
		if IsValidInput ~= nil then
			IsValidInput(Player)
		end
	end)
	_MouseConnection = Mouse.Button1Up:Connect(function()
		MouseClickModule(Player)
	end)
end
