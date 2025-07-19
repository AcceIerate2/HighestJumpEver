local function GetInstance(Player : Player, InstanceName : string) : Instance | nil
    local InstanceToReturn = nil :: Instance | nil
    for Index, OBJ in pairs(Player:GetChildren()) do
        if OBJ:IsA("Folder") then
            InstanceToReturn = OBJ:FindFirstChild(InstanceName)
            if InstanceToReturn ~= nil then return InstanceToReturn end
        elseif OBJ:IsA("ValueBase") then
            if OBJ.Name == InstanceName then 
                InstanceToReturn = OBJ 
                return InstanceToReturn
            end
        else
            continue
        end
    end
    return InstanceToReturn
end
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvents = ReplicatedStorage.Events.RemoteEvents
local function SetValues(Player : Player, Data : {} | nil) : boolean
    if not Player then error("Given Player Argument is nil!") return false end
    if typeof(Data) == "table" then
        for InstanceName, Value in pairs(Data) do
            local SavableInstance = GetInstance(Player, InstanceName)
            if SavableInstance ~= nil and SavableInstance:IsA("ValueBase") then
                SavableInstance.Value = Value
            end
        end
        RemoteEvents.ShowDailyRewards:FireClient(Player)
        return true
    elseif Data == nil then
        print("New Player.")
        Player.JoinDate.Value = os.time()
        RemoteEvents.ShowTutorial:FireClient(Player)
        return true
    end
    return false
end
local function Request(DataStore : DataStore, Key : string)
    if not DataStore or not Key then error("Given Arguments were nil!") return false, {} end
    local Status, Response = pcall(function()
        return DataStore:GetAsync(Key)
    end)
    if Status == false then warn(Response) end
    if typeof(Response) == "string" then
        Response = {}
    end
    return Status, Response
end
local MaxRetries = 3
return function(DataStore : DataStore, Player : Player) : boolean
    if not DataStore or not Player then error("Given Arguements were nil!") return false end
    local Key = tostring(Player.UserId) :: string
    for Index = MaxRetries, 1, -1 do
        local Status, Response = Request(DataStore, Key)
        if Status == true then
            local ValuesSet = SetValues(Player, Response) :: boolean
            if ValuesSet and typeof(ValuesSet) == "boolean" and ValuesSet == true then
                return Status
            end
        end
        task.wait(1)
    end
    return false
end