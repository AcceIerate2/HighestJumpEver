local MaxRetires = 3
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AvatarHeadshotModule = require(ReplicatedStorage.Shared.AvatarHeadshot)
local NumberShortnerModule = require(ReplicatedStorage.Shared.NumberShortner)
local PlayerService = game:GetService("Players")
local RunService = game:GetService("RunService")
local LeaderboardFolder = workspace:FindFirstChild("leaderboards")
local DisabledKeyNumbers = {
	"1850876647",
}
local function Update_Humanoid_Description(UserId: number, Part: BasePart)
	local success, New_Humanoid_Description = pcall(function()
		return PlayerService:GetHumanoidDescriptionFromUserId(UserId)
	end)
	if success and New_Humanoid_Description then
		local Ldb_Rig = Part:FindFirstChildOfClass("Model")
		if Ldb_Rig and Ldb_Rig:FindFirstChildOfClass("Humanoid") and Ldb_Rig:FindFirstChild("HumanoidRootPart") then
			local Ldb_Humanoid = Ldb_Rig:FindFirstChildOfClass("Humanoid")
			Ldb_Humanoid:ApplyDescription(New_Humanoid_Description)

			task.wait(1)

			-- Resize To Original Size
			for index: number, NumberValue in pairs(Ldb_Humanoid:GetChildren()) do
				if NumberValue and NumberValue:IsA("NumberValue") then
					NumberValue.Value = ServerStorage.LeaderboardAssets:FindFirstChild(NumberValue.Name).Value
				end
			end

			-- Reset Position down to ground level
			Ldb_Rig.HumanoidRootPart.Anchored = true
			if Part.Name == "Cash" then
				Ldb_Rig:PivotTo(
					CFrame.new(
						-28.8796272,
						-1.99249125,
						-13.3549118,
						-0.615666866,
						4.12886251e-13,
						-0.788019061,
						-5.68670138e-14,
						1,
						5.68384966e-13,
						0.788019061,
						3.94748687e-13,
						-0.615666866
					)
				)
			elseif Part.Name == "Rebirths" then
				Ldb_Rig:PivotTo(
					CFrame.new(
						-3.23769188,
						-1.99249125,
						-33.9586792,
						-1.00000894,
						-5.68682674e-14,
						-1.31782926e-07,
						-5.6867976e-14,
						1,
						5.68378461e-13,
						1.31782926e-07,
						5.68383665e-13,
						-1.00000894
					)
				)
			elseif Part.Name == "HighestAltitude" then
				Ldb_Rig:PivotTo(
					CFrame.new(
						29.4655819,
						-1.99249077,
						-24.763979,
						-0.819164336,
						-3.72597623e-13,
						0.573584914,
						-5.68678744e-14,
						1,
						5.68378406e-13,
						-0.573584914,
						4.32976842e-13,
						-0.819164336
					)
				)
			end
			task.wait(1)
			Ldb_Rig.HumanoidRootPart.Anchored = true

			local Status, PlrName = pcall(function()
				return PlayerService:GetNameFromUserIdAsync(UserId)
			end)

			if Status then
				if Ldb_Rig.Head:FindFirstChildOfClass("BillboardGui") then
					Ldb_Rig.Head.BillboardGui:Destroy()
				end

				local NewBillBoard = ServerStorage.LeaderboardAssets:FindFirstChildOfClass("BillboardGui"):Clone()
				NewBillBoard.Frame.TextLabel.Text = PlrName

				if Part.Name == "Rebirths" then
					NewBillBoard.Frame.TextLabel.TextColor3 = Color3.fromRGB(199, 67, 255)
				elseif Part.Name == "Cash" then
					NewBillBoard.Frame.TextLabel.TextColor3 = Color3.fromRGB(13, 255, 0)
				elseif Part.Name == "HighestAltitude" then
					NewBillBoard.Frame.TextLabel.TextColor3 = Color3.fromRGB(73, 197, 255)
				end

				NewBillBoard.Parent = Ldb_Rig.Head

				for index, BasePart in pairs(Ldb_Rig:GetDescendants()) do
					if BasePart:IsA("BasePart") then
						BasePart.CollisionGroup = "Players"
					end
				end
			else
				warn(PlrName, "LeaderboardSystem - Line 60 - GetNameFromUserIdAsync")
			end
		else
			warn(
				"Could not find humanoid in ldb Rig or could not find model under ldb part! LdbPartName : " .. Part.Name
			)
			local Retry = Reset_Leaderboard_Rig(Part) :: boolean
			if Retry == true then
				warn("Retrying 'Update_Humanoid_Description' function! line 66 - LeaderboardSystem [Ignorable!]")
				Update_Humanoid_Description(Part, UserId)
			end
		end
	elseif not success then
		warn(New_Humanoid_Description)
	end
end
local function InitRig(Username: string, Key: number, LeaderboardType: string)
	local Part = LeaderboardFolder:FindFirstChild(LeaderboardType)
	if Part then
		Update_Humanoid_Description(Key, Part)
	else
		warn(`Could not find Part: {LeaderboardType}_LDB_Part`)
	end
end
local function RequestUsername(Key: number)
	if not Key then
		return false
	end
	local Status, Response = pcall(function()
		return PlayerService:GetNameFromUserIdAsync(Key)
	end)
	if Status == false then
		warn(Response)
		return Status, nil
	end
	return Status, Response
end
local CollectionService = game:GetService("CollectionService")
local MaxNumberHandler = require(script.Parent.MaxNumberHandler)
local function Display(MainData: {}, LeaderboardType: string)
	local ScrollingFrame = CollectionService:GetTagged(`{LeaderboardType}_LDB`)[1]
	if not ScrollingFrame then
		return false
	end
	for Index, UiElement in pairs(ScrollingFrame:GetChildren()) do
		if UiElement and UiElement:IsA("Frame") and UiElement.Visible == true then
			UiElement:Destroy()
		end
	end
	local Template = ScrollingFrame:FindFirstChild("Template")
	if not Template then
		return false
	end

	for _Rank, Data in pairs(MainData) do
		local Key = Data.key
		if table.find(DisabledKeyNumbers, Key) or tonumber(Key) < 1000 then
			continue
		end
		local _Value = Data.value
		local ValueName = LeaderboardType
		if LeaderboardType == "HighestAltitude" then
			ValueName = "HighestJump"
		end
		local SavedAsAHugeNumber = MaxNumberHandler(false, Key, ValueName)
		if typeof(SavedAsAHugeNumber) == "number" then
			_Value = SavedAsAHugeNumber
		end
		Data.value = _Value
	end

	table.sort(MainData, function(a, b)
		return a.value > b.value
	end)

	for Rank, Data in pairs(MainData) do
		local Key = Data.key
		if table.find(DisabledKeyNumbers, Key) or tonumber(Key) < 1000 then
			continue
		end
		local Value = Data.value
		local ValueName = LeaderboardType
		if LeaderboardType == "HighestAltitude" then
			ValueName = "HighestJump"
		end
		local SavedAsAHugeNumber = MaxNumberHandler(false, Key, ValueName)
		if typeof(SavedAsAHugeNumber) == "number" then
			Value = SavedAsAHugeNumber
		end

		local Username = "loading.."
		for Index = MaxRetires, 1, -1 do
			local Status, Response = RequestUsername(tonumber(Key))
			if Status == true then
				Username = Response
				break
			elseif Status == false then
				task.wait(1)
			end
		end
		local UserAvatar = AvatarHeadshotModule(tonumber(Key))
		local ClonedTemplate = Template:Clone()
		if ClonedTemplate then
			if UserAvatar and typeof(UserAvatar) == "string" then
				ClonedTemplate:WaitForChild("1").ICON.Image = UserAvatar
			end
			ClonedTemplate:WaitForChild("1").USERNAME.Text = Username
			ClonedTemplate["2"].amount.Text = NumberShortnerModule(Value)
			ClonedTemplate.Visible = true
			ClonedTemplate.Parent = ScrollingFrame
			if Rank == 1 then
				InitRig(Username, Key, LeaderboardType)
			end
		end
		RunService.Heartbeat:Wait()
	end
end
local PageSize = 50 :: number
local function Request(DataStore, LeaderboardType: string): boolean
	local Status, Response = pcall(function()
		return DataStore:GetSortedAsync(false, 100)
	end)
	if Status == false then
		warn(Response)
		return false, nil
	end
	if Status == true and Response then
		return true, Response:GetCurrentPage(PageSize)
	end
	return Status, nil
end
return function(DataStore, LeaderboardType: string)
	for Index = MaxRetires, 1, -1 do
		local Status, Data = Request(DataStore, LeaderboardType)
		if Status and typeof(Status) == "boolean" and Status == true then
			task.spawn(Display, Data, LeaderboardType)
			break
		else
			task.wait(1)
		end
	end
	return true
end
