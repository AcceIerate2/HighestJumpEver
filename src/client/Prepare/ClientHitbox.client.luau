local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local StarterPlayer = game:GetService("StarterPlayer")
local CanvasToggler = require(StarterPlayer.StarterPlayerScripts.Client.UserInterface.Buttons.Canvas.CanvasToggler)
local TagToGet = "ClientHitbox"

local Functions = {
	["Canvas"] = function(Part: BasePart)
		if not Part then
			return
		end
		local Name = Part:GetAttribute("Name")
		local CustomSectionIfAny = Part:GetAttribute("Section")
		if not Name then
			return
		end
		CanvasToggler(Name, CustomSectionIfAny)
	end,
}

local Debounce = false
local function _init()
	for _Index, BsaePart in pairs(CollectionService:GetTagged(TagToGet)) do
		if BsaePart:IsA("BasePart") then
			BsaePart.Touched:Connect(function(PartTouched: BasePart)
				if Debounce == true then
					return
				end
				Debounce = true
				local Humanoid = PartTouched.Parent:FindFirstChild("Humanoid")
					or PartTouched.Parent.Parent:FindFirstChild("Humanoid")
				if Humanoid and Humanoid:IsA("Humanoid") then
					local Character = Humanoid.Parent
					if Character and Character:IsA("Model") then
						local Player = Players:GetPlayerFromCharacter(Character)
						if Player and Player:IsA("Player") then
							if Player == Players.LocalPlayer then
								local FunctionToCall = Functions[BsaePart:GetAttribute("Type")]
								if FunctionToCall then
									FunctionToCall(BsaePart)
								end
							end
						end
					end
				end
				task.wait(2)
				Debounce = false
			end)
		end
	end
end
_init()
