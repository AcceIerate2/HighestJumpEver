local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ClaimRewardRF =
	ReplicatedStorage:WaitForChild("Events"):WaitForChild("RemoteFunctions"):WaitForChild("ClaimReward")
local NotifyBE = ReplicatedStorage:WaitForChild("Events"):WaitForChild("BindableEvents"):WaitForChild("Notify")

local SoundService = game:GetService("SoundService")
local RebirthSuccessSFX = SoundService:WaitForChild("Rebirth")
local ErrorSFX = SoundService:WaitForChild("Error")

local MarketPlaceService = game:GetService("MarketplaceService")
local StarterPlayer = game:GetService("StarterPlayer")
local Prompt = require(StarterPlayer.StarterPlayerScripts.Client.UserInterface.Buttons.Prompt)
local SkipProductId = 3271381820
return function(Button: GuiButton, Player: Player, PlayerGui: PlayerGui)
	local PlayerIsInGroup = Player:IsInGroup(35831908)
	if PlayerIsInGroup == true then
		local Status, Message, TextColor = ClaimRewardRF:InvokeServer()
		NotifyBE:Fire(Message, TextColor)
		-- To Play SFX
		if Status == true then
			RebirthSuccessSFX:Play()
			ReplicatedStorage:WaitForChild("Events"):WaitForChild("BindableEvents"):WaitForChild("Confetti"):Fire()
			Button.Parent.Parent.Visible = false
		elseif Status == false then
			ErrorSFX:Play()
			Prompt(Button, Player, PlayerGui)
		end
	elseif PlayerIsInGroup == false then
		NotifyBE:Fire("You are not in the group!", Color3.fromRGB(255, 0, 0))
	end
end
