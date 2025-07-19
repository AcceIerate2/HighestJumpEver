local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Upgrades = require(ReplicatedStorage:WaitForChild("UpgradeData"))

local HttpService = game:GetService("HttpService")
local function Update(Name: string, Player: Player, PlayerGui: PlayerGui, init: boolean)
	local CanvasGroup = PlayerGui:WaitForChild("Frames"):WaitForChild("Upgrades"):WaitForChild("Frame")
	local ViewingFrame = CanvasGroup:WaitForChild("View")
	local PlayerUpgradeData = HttpService:JSONDecode(Player:WaitForChild("UpgradeData").Value)
	if PlayerUpgradeData then
		local Level = PlayerUpgradeData[Name]

		local MultiplierText = nil
		local Price = nil
		if Level == 0 then
			MultiplierText = Upgrades[Name]["DefaultMultiplierText"]
		elseif Level > 0 and Level < 4 then
			MultiplierText = Upgrades[Name]["Levels"][Level - 1][2]
		elseif Level >= #Upgrades[Name]["Levels"] then
			MultiplierText = Upgrades[Name]["Levels"][Level - 1][2]
			Price = ""
		end

		local Description = Upgrades[Name]["Description"]
		if Price == nil then
			Price = `💎 {Upgrades[Name]["Levels"][Level][1]}`
		end

		ViewingFrame:WaitForChild("Price").Text = Price
		if init then
			ViewingFrame:WaitForChild("Multiplier").Text = `{MultiplierText}`
		else
			if Name == "Fast Chug" then
				ViewingFrame:WaitForChild("Multiplier").Text = `Current: {MultiplierText}`
			else
				ViewingFrame:WaitForChild("Multiplier").Text = `Current: x{MultiplierText}`
			end
		end
		ViewingFrame:WaitForChild("Level").Text = `Level {Level}`
		ViewingFrame:WaitForChild("Description").Text = Description
		ViewingFrame:WaitForChild("Title"):WaitForChild("TextLabel").Text = Name
		ViewingFrame:WaitForChild("Upgrade"):SetAttribute("SelectedUpgrade", Name)
	end
end

return function(Button: GuiButton | string, Player: Player, PlayerGui: PlayerGui, init: boolean)
	local Name = nil
	if typeof(Button) == "string" then
		Name = Button
	elseif typeof(Button) == "Instance" then
		Name = Button.Name
	end
	Update(Name, Player, PlayerGui, init)
end
