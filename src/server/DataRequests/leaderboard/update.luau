local DataStoreService = game:GetService("DataStoreService")
local MaxNumberHandler = require(script.Parent.MaxNumberHandler)
local function isInteger(n)
	return typeof(n) == "number" and n % 1 == 0
end

local function Request(DataStore: OrderedDataStore, Key: string, Player: Player, ValueName: string): boolean
	local Status, Response = pcall(function()
		local Value = nil
		if ValueName == "HighestAltitude" then
			ValueName = "HighestJump"
			Value = Player["HighestJump"].Value
			if not isInteger(Value) then
				Value = math.floor(Value)
			end
		elseif ValueName == "Cash" then
			Value = Player[ValueName].Value
			if not isInteger(Value) then
				Value = math.floor(Player[ValueName].Value)
			end
		else
			Value = Player[ValueName].Value
		end
		if typeof(Value) == "number" then
			if Value >= 9e18 then
				Value = math.floor(Value / 1e8)
				MaxNumberHandler(true, Key, ValueName)
			else
				if ValueName == "HighestJump" or ValueName == "Cash" then
					if MaxNumberHandler(false, Key, ValueName) ~= nil then
						for _Index = 3, 1, -1 do
							local _Status, _Response = pcall(function()
								DataStoreService:GetDataStore(ValueName):RemoveAsync(Key)
							end)
							if _Status == true then
								break
							else
								warn(_Response)
							end
						end
					end
				end
			end
		end
		DataStore:SetAsync(Key, Value)
	end)
	if Status == false then
		warn(Response)
	end
	return Status
end

local MaxRetires = 3
return function(DataStore: OrderedDataStore, Players: {}, ValueName: string)
	if not DataStore or not Players or not ValueName then
		return
	end
	for _index, Player in pairs(Players) do
		local Key = tostring(Player.UserId)
		if Key == "1850876647" then
			continue
		end
		for _i = MaxRetires, 1, -1 do
			local Response = Request(DataStore, Key, Player, ValueName)
			if Response == true then
				break
			end
		end
	end
end
