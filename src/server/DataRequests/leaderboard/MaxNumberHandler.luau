local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local DataStores = {
	["HighestJump"] = DataStoreService:GetDataStore("HighestJump"),
	["Cash"] = DataStoreService:GetDataStore("Cash"),
}

local MaxRetries = 3

local function Request(Type, ValueName: string, ...): (boolean, any)
	local Args = { ... }
	local DataStore = DataStores[ValueName]
	if DataStore then
		local Status, Response = pcall(function()
			return DataStore[Type](DataStore, table.unpack(Args))
		end)
		return Status, Response
	end
	return false, nil
end

local function _SaveOriginalNumber(Key: string, Player: Player | nil, ValueName: string)
	if not Player or not Key or not ValueName then
		return
	end
	local ValueBaseInstance = Player:FindFirstChild(ValueName)
	if ValueBaseInstance then
		local _Response = nil
		local _Status = false
		for _Index = MaxRetries, 1, -1 do
			_Status, _Response = Request("SetAsync", ValueName, Key, math.floor(ValueBaseInstance.Value))
			if _Status == true then
				break
			end
		end
	end
end

-- returns nil if the user isnt in the table
return function(Save: boolean, Key: string, ValueName: string): number | nil
	if Save == nil or Save == false then
		local _NumberValueIfAny = nil
		local _Status = false
		for _Index = MaxRetries, 1, -1 do
			_Status, _NumberValueIfAny = Request("GetAsync", ValueName, Key)
			if _Status == true then
				break
			else
				continue
			end
		end
		return _NumberValueIfAny
	elseif Save and Save == true then
		local Player = Players:GetPlayerByUserId(tonumber(Key))
		if Player and Player:IsA("Player") then
			_SaveOriginalNumber(Key, Player, ValueName)
		end
	end
	return nil
end
