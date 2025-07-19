local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AvatarHeadshotModule = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("AvatarHeadshot"))
local NumberShortnerModule = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("NumberShortner"))
local PlayerService = game:GetService("Players")
local function AddTemplate(ScrollingFrame : ScrollingFrame, DataModel : {},Layout : number) : boolean
    local OtherPlayerName = DataModel[1]
    local CurrentAltitude = DataModel[2]
    local Evolutions = DataModel[3]
    
    if ScrollingFrame:WaitForChild("Username"):WaitForChild("values"):FindFirstChild(OtherPlayerName.Name) then
        local UsernameFrame = ScrollingFrame:WaitForChild("Username"):WaitForChild("values"):WaitForChild(OtherPlayerName.Name)
        UsernameFrame:WaitForChild("Label").Text = OtherPlayerName.Name
        local Status, Response = pcall(function()
            UsernameFrame:WaitForChild("Icon").Image = AvatarHeadshotModule(OtherPlayerName)
        end)
        if Status == false then warn(Response) end
        UsernameFrame.LayoutOrder = Layout
            
        local CurrentAltitudeFrame = ScrollingFrame:WaitForChild("CurrentAltitude"):WaitForChild("values"):WaitForChild(OtherPlayerName.Name)
        CurrentAltitudeFrame:WaitForChild("Label").Text = `{NumberShortnerModule(CurrentAltitude)} m`
        CurrentAltitudeFrame.LayoutOrder = Layout

        local EvolutionsFrame = ScrollingFrame:WaitForChild("Evolutions"):WaitForChild("values"):WaitForChild(OtherPlayerName.Name)
        EvolutionsFrame:WaitForChild("Label").Text = `{NumberShortnerModule(Evolutions)}`
        EvolutionsFrame.LayoutOrder = Layout
    else
        local LayoutOrder = 0
        local UsernameFrame = ScrollingFrame:WaitForChild("Username"):WaitForChild("values"):WaitForChild("Template"):Clone()
        if UsernameFrame then
            UsernameFrame.Name = OtherPlayerName.Name
            UsernameFrame:WaitForChild("Label").Text = OtherPlayerName.Name
            local Status, Response = pcall(function()
                UsernameFrame:WaitForChild("Icon").Image = AvatarHeadshotModule(OtherPlayerName)
            end)
            if Status == false then warn(Response) end
            UsernameFrame.Visible = true
            UsernameFrame.LayoutOrder = #ScrollingFrame:WaitForChild("Username"):WaitForChild("values"):GetChildren()
            LayoutOrder = UsernameFrame.LayoutOrder
            UsernameFrame.Parent = ScrollingFrame:WaitForChild("Username"):WaitForChild("values")
        end

        local CurrentAltitudeFrame = ScrollingFrame:WaitForChild("CurrentAltitude"):WaitForChild("values"):WaitForChild("Template"):Clone()
        if CurrentAltitudeFrame then
            CurrentAltitudeFrame.Name = OtherPlayerName.Name
            CurrentAltitudeFrame:WaitForChild("Label").Text = `{NumberShortnerModule(CurrentAltitude)} m`
            CurrentAltitudeFrame.LayoutOrder = LayoutOrder
            CurrentAltitudeFrame.Visible = true
            CurrentAltitudeFrame.Parent = ScrollingFrame:WaitForChild("CurrentAltitude"):WaitForChild("values")
        end

        local EvolutionsFrame = ScrollingFrame:WaitForChild("Evolutions"):WaitForChild("values"):WaitForChild("Template"):Clone()
        if EvolutionsFrame then
            EvolutionsFrame.Name = OtherPlayerName.Name
            EvolutionsFrame:WaitForChild("Label").Text = `{NumberShortnerModule(Evolutions)}`
            EvolutionsFrame.LayoutOrder = LayoutOrder
            EvolutionsFrame.Visible = true
            EvolutionsFrame.Parent = ScrollingFrame:WaitForChild("Evolutions"):WaitForChild("values")
        end
    end
    
    return true
end
local RunService = game:GetService("RunService")
return function(Player : Player, PlayerGui : PlayerGui)
    local ScrollingFrame = PlayerGui:WaitForChild("leaderstats"):WaitForChild("Frame"):WaitForChild("ScrollingFrame")
    task.spawn(function()
        while task.wait() do
            local Data = {}
            for index, OtherPlayer in pairs(PlayerService:GetPlayers()) do
                local CurrentAltitude = OtherPlayer:WaitForChild("CurrentAltitude")
                local Evolutions = OtherPlayer:WaitForChild("Evolutions")
                table.insert(Data, {OtherPlayer, CurrentAltitude.Value, Evolutions.Value})
            end
            table.sort(Data, function(a,b)
                return a[3] > b[3]
            end)

            for index, DataModel in pairs(Data) do
                AddTemplate(ScrollingFrame, DataModel, index)
            end
            
            for index, Element in pairs(ScrollingFrame:GetChildren()) do
                if Element:IsA("Frame") then
                    for secondIndex, SecondElement in pairs(Element:WaitForChild("values"):GetChildren()) do
                        if SecondElement and SecondElement:IsA("Frame") and SecondElement.Visible == true then
                            local PlayerNameIfAny = SecondElement.Name
                            if not PlayerService:FindFirstChild(PlayerNameIfAny) then
                                SecondElement:Destroy()
                            end
                        end
                    end
                end
            end
        end
    end)
end