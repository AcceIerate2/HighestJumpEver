local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPlayer = game:GetService("StarterPlayer")
local PurchaseRF = ReplicatedStorage:WaitForChild("Events"):WaitForChild("RemoteFunctions"):WaitForChild("Purchase")
local NotifyBE = ReplicatedStorage:WaitForChild("Events"):WaitForChild("BindableEvents"):WaitForChild("Notify")
local CanvasToggler = require(StarterPlayer.StarterPlayerScripts.Client.UserInterface.Buttons.Canvas.CanvasToggler)
local Prompt = require(StarterPlayer.StarterPlayerScripts.Client.UserInterface.Buttons.Prompt)
local ToolbarModule = require(script.Parent.Parent.Parent.Parent:WaitForChild("Toolbar"))
return function(Button, Player: Player, PlayerGui: PlayerGui)
	if not Button or not Player or not PlayerGui then
		return
	end
	local ToolName = Button:GetAttribute("Selected")
	if ToolName and typeof(ToolName) == "string" then
		local Status, Message, ColorIfAny = PurchaseRF:InvokeServer(ToolName)
		NotifyBE:Fire(Message, ColorIfAny)
		if Status == "Bought" then
			Button:WaitForChild("TextLabel").Text = "Equip"
		elseif Status == "Equipped" then
			local Character = Player.Character
			if Character then
				local ToolEquipped = Character:FindFirstChildOfClass("Tool")
				if ToolEquipped then
					ToolbarModule("Drink")
					ToolbarModule("Drink")
				end
			end
			Button:WaitForChild("TextLabel").Text = "Equipped"
		elseif Status == "Robux" then
			local BtnSelectionTemplate = Button.Parent.Parent.Selection.ScrollingFrame:FindFirstChild(ToolName)
			if BtnSelectionTemplate and BtnSelectionTemplate:IsA("GuiButton") then
				local DataToSend = {
					["id"] = BtnSelectionTemplate:GetAttribute("id"),
					["PromptType"] = BtnSelectionTemplate:GetAttribute("PromptType"),
				}
				Prompt(DataToSend, Player, PlayerGui)
			end
		elseif Status == "Not Enough Cash" then
			CanvasToggler("Shop", "Cash")
		end
	end
end
