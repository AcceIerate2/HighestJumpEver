local DataStoreService = game:GetService("DataStoreService")
local UserData = DataStoreService:GetDataStore("UserData_Development_Testing_Phase_5") --UserData_Development_Testing_Phase_4

local RequestTypes = {
    ["Get"] = require(script.Get),
    ["Save"] = require(script.Save)
}

return function(RequestType : string, Player : Player) : boolean
    local RequestFunction = RequestTypes[RequestType]
    if RequestFunction then
        return RequestFunction(UserData, Player) :: boolean
    end
    return false
end