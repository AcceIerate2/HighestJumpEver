local function Request(DataStore : DataStore, Key : string, DataToSave : {}) : boolean
    if not DataStore or not Key or not DataToSave then error("Given Arguments are nil!") return false end
    local Status, Response = pcall(function()
        DataStore:SetAsync(Key, DataToSave)
    end)
    if Status == false then warn(Response) end
    return Status :: boolean
end
local function GetDataToSave(Player : Player) : {}
    local DataToSave = {} :: {}
    for Index, SavableInstance in pairs(Player:GetDescendants()) do
        if not SavableInstance:HasTag("Savable") then continue end
        DataToSave[SavableInstance.Name] = SavableInstance.Value 
    end
    return DataToSave
end
local MaxRetries = 3 :: number
return function(DataStore : DataStore, Player : Player) : boolean
    if not DataStore or not Player then return false end
    local DataToSave = GetDataToSave(Player) :: {}
    local SaveSuccess = false :: boolean
    local Key = tostring(Player.UserId) :: string
    for Index = MaxRetries, 1, -1 do
        local Status = Request(DataStore, Key, DataToSave)
        SaveSuccess = Status
        if Status == true then break end
        task.wait(1)
    end
    return SaveSuccess
end