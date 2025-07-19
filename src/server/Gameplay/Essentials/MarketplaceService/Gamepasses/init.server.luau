local MarketPlaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BindableEvents = ReplicatedStorage.Events.BindableEvents
local PlayerJoinBE = BindableEvents.PlayerJoin

local PassIds = require(script.PassIds)

MarketPlaceService.PromptGamePassPurchaseFinished:Connect(
	function(Player: Player, PassId: number, wasPurchased: boolean)
		if Player and PassId and wasPurchased == true then
			ReplicatedStorage.Events.RemoteEvents.Confetti:FireClient(Player)
			local FunctionToCall = PassIds[PassId]
			if FunctionToCall then
				FunctionToCall(Player)
				ReplicatedStorage.Events.RemoteEvents.Confetti:FireClient(Player)
			end
		end
	end
)

local function OwnsPass(Player: Player, PassId: number)
	local Status, Response = pcall(function()
		return MarketPlaceService:UserOwnsGamePassAsync(Player.UserId, PassId)
	end)
	if Status == true then
		return Response
	elseif Status == false then
		warn(Response)
		return false
	end
end

PlayerJoinBE.Event:Connect(function(Player: Player)
	Player:WaitForChild("DataSynced")
	task.spawn(function()
		for PassId, FunctionToCall in pairs(PassIds) do
			local PlayerOwnsPass = OwnsPass(Player, PassId) :: boolean
			if PlayerOwnsPass == true then
				FunctionToCall(Player, true)
			end
			task.wait(1)
		end
		local PassesLoaded = Instance.new("BoolValue")
		PassesLoaded.Name = "PassesLoaded"
		PassesLoaded.Parent = Player
	end)
end)
