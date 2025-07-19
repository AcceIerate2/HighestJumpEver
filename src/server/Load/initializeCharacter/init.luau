local Connection = nil
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VfxFolder = ReplicatedStorage.Vfx
local AnimationModule = require(ReplicatedStorage.Shared.Animations)
local function SetupVfx(Character: Model)
	local Impact = VfxFolder:FindFirstChild("Impact"):Clone()
	Impact.Parent = Character:FindFirstChild("LeftFoot")
end
local PhysicsService = game:GetService("PhysicsService")
local GroupName = "Players"
PhysicsService:RegisterCollisionGroup(GroupName)
PhysicsService:CollisionGroupSetCollidable(GroupName, GroupName, false)
local CharacterSounds = ReplicatedStorage.CharacterSounds
local function LoadSounds(HumanoidRootPart: BasePart)
	for _Index, SoundOBJ in pairs(CharacterSounds:GetChildren()) do
		local ClonedSound = SoundOBJ:Clone()
		ClonedSound.Name = `{ClonedSound.Name}_Custom`
		ClonedSound.Parent = HumanoidRootPart
	end
end
local function RemoveWingAccessories(Character: Model)
	if not Character then
		return
	end
	if Character:IsA("Model") then
		for _Index, Accessory in pairs(Character:GetChildren()) do
			if Accessory:IsA("Accessory") then
				local WingInName = string.find(string.lower(Accessory.Name), "wing")
				if Accessory.AccessoryType == Enum.AccessoryType.Back or WingInName ~= nil then
					Accessory:Destroy()
				end
			end
		end
	end
end

local PlrStatusModule = require(script.PlrStatus)
return function(Player: Player)
	Connection = Player.CharacterAdded:Connect(function(Character: Model)
		for _Index, BasePart in pairs(Character:GetDescendants()) do
			if BasePart:IsA("BasePart") then
				BasePart.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0, 1, 100)
				BasePart.Massless = true
				BasePart.CollisionGroup = "Players"
			end
		end
		local Humanoid = Character:FindFirstChild("Humanoid") :: Humanoid
		Humanoid.JumpHeight = 0
		local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
		Player.RootCFrame.Value = HumanoidRootPart.CFrame
		for _Index, AnimationSound in pairs(ReplicatedStorage.AnimationObjects:GetChildren()) do
			if not AnimationSound:IsA("Animation") then
				continue
			end
			local Name = AnimationSound.Name
			AnimationModule(Player, Name, true)
			print(`Loaded Animation: {Name}.`)
		end
		LoadSounds(HumanoidRootPart)
		SetupVfx(Character)
		RemoveWingAccessories(Character)
		PlrStatusModule(Player, Humanoid, HumanoidRootPart)
	end)
end
