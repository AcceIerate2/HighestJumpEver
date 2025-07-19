local ButtonTypes = {
	["Action"] = require(script:WaitForChild("Actions")),
	["Prompt"] = require(script:WaitForChild("Prompt")),
	["Canvas"] = require(script:WaitForChild("Canvas")),
}
local Connections = {}
local AnimateModule = require(script:WaitForChild("Animate"))
local CollectionService = game:GetService("CollectionService")
return function(Player: Player, PlayerGui: PlayerGui)
	local Buttons = CollectionService:GetTagged("GuiButton") :: {}
	for Index, Button in pairs(Buttons) do
		if not Button:IsA("GuiButton") then
			continue
		end
		AnimateModule(Button)
		local ButtonType = Button:GetAttribute("Type")
		local FunctionIfAny = ButtonTypes[ButtonType]
		if FunctionIfAny then
			Connections[Button] = Button.Activated:Connect(function()
				local AlertFrameIfAny = Button:FindFirstChild("alert")
				if AlertFrameIfAny and AlertFrameIfAny:IsA("Frame") then
					AlertFrameIfAny.Visible = false
				end
				FunctionIfAny(Button, Player, PlayerGui)
			end)
		end
	end
end
