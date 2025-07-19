local MarketplaceService = game:GetService("MarketplaceService")
local PlayerService = game:GetService("Players")
local Player = PlayerService.LocalPlayer

local TweenService = game:GetService("TweenService")
local TweenConfiguration = TweenInfo.new(0.25, Enum.EasingStyle.Linear)

local SoundService = game:GetService("SoundService")
local PurchaseSFX = SoundService:WaitForChild("Purchase")

local PlayerGUi = Player:WaitForChild("PlayerGui")
local ShadowCanvas = PlayerGUi:WaitForChild("Shadow"):WaitForChild("CanvasGroup")
local LoadingWheel = ShadowCanvas:WaitForChild("ImageLabel")
local ActiveThread = nil
local BreakThread = false
local function ToggleLoadingWheel()
	if ActiveThread == nil then
		LoadingWheel.Rotation = 0
		ActiveThread = task.spawn(function()
			while task.wait() do
				if BreakThread == true then
					break
				end
				LoadingWheel.Rotation += 2
			end
			BreakThread = false
		end)
	else
		if ActiveThread and typeof(ActiveThread) == "thread" then
			BreakThread = true
			ActiveThread = nil
		end
	end
end

local function TogglePurchaseEffect()
	if ShadowCanvas.GroupTransparency == 1 then
		local Tween = TweenService:Create(ShadowCanvas, TweenConfiguration, { ["GroupTransparency"] = 0 })
		Tween:Play()
	elseif ShadowCanvas.GroupTransparency == 0 then
		local Tween = TweenService:Create(ShadowCanvas, TweenConfiguration, { ["GroupTransparency"] = 1 })
		Tween:Play()
	end
	ToggleLoadingWheel()
end

local Cooldown = false
local PromptTypes = {
	["Pass"] = function(id: number)
		ShadowCanvas.GroupTransparency = 1
		TogglePurchaseEffect()
		local Status, Response = pcall(function()
			MarketplaceService:PromptGamePassPurchase(Player, id)
		end)
		if Status == false then
			warn(Response)
			TogglePurchaseEffect()
		elseif Status == true then
			MarketplaceService.PromptGamePassPurchaseFinished:Wait()
			TogglePurchaseEffect()
		end
		task.wait(1)
		Cooldown = false
	end,

	["Product"] = function(id: number)
		ShadowCanvas.GroupTransparency = 1
		TogglePurchaseEffect()
		local Status, Response = pcall(function()
			MarketplaceService:PromptProductPurchase(Player, id)
		end)
		if Status == false then
			warn(Response)
			TogglePurchaseEffect()
		elseif Status == true then
			MarketplaceService.PromptProductPurchaseFinished:Wait()
			TogglePurchaseEffect()
		end
		task.wait(1)
		Cooldown = false
	end,
}
return function(Button: GuiButton | {}, _Player: Player, _PlayerGui: PlayerGui)
	if not Button then
		return
	end
	if typeof(Button) == "Instance" and Button:IsA("GuiButton") then
		local id = Button:GetAttribute("id")
		if id then
			local PromptType = Button:GetAttribute("PromptType")
			if PromptType ~= nil and typeof(PromptType) == "string" then
				local FunctionToCall = PromptTypes[PromptType]
				if FunctionToCall then
					Button.Activated:Connect(function()
						if Cooldown == true then
							return
						end
						Cooldown = true
						PurchaseSFX:Play()
						FunctionToCall(id)
					end)
				end
			end
		end
	elseif typeof(Button) == "table" then
		local id = Button["id"]
		local PromptType = Button["PromptType"]
		if id and PromptType then
			local FunctionToCall = PromptTypes[PromptType]
			if FunctionToCall then
				if Cooldown == true then
					return
				end
				Cooldown = true
				PurchaseSFX:Play()
				FunctionToCall(id)
			end
		end
	end
end
