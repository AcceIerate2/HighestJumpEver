local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteFunction = ReplicatedStorage:WaitForChild("Events"):WaitForChild("RemoteFunctions"):WaitForChild("ClaimJumpCoil")

local TimeFormatterModule = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("FormatTime"))
local TextLabel = workspace:WaitForChild("JumpCoil"):WaitForChild("Gui"):WaitForChild("Main"):WaitForChild("Frame"):WaitForChild("TextLabel")
local DayInSeconds = 86400

local Debounce = false
local ConfettiBE = ReplicatedStorage:WaitForChild("Events"):WaitForChild("BindableEvents"):WaitForChild("Confetti")
local NotifyBE = ReplicatedStorage:WaitForChild("Events"):WaitForChild("BindableEvents"):WaitForChild("Notify")
local function InitTouchConnection(Player : Player)
    workspace:WaitForChild("JumpCoil"):WaitForChild("Hitbox").Touched:Connect(function(OtherPart : BasePart)
        if Debounce then return end
        Debounce = true
        local Humanoid = OtherPart.Parent:FindFirstChildOfClass("Humanoid") or OtherPart.Parent.Parent:FindFirstChildOfClass("Humanoid")
        if Humanoid then
            local Character = Humanoid.Parent
            if Character:IsA("Model") then
                if Character == Player.Character then
                    local ClaimedJumpCoil = Player:WaitForChild("ClaimedJumpCoil")
                    if ClaimedJumpCoil.Value == true then
                        NotifyBE:Fire("You already claimed this!", Color3.fromRGB(255,0,0))
                    elseif ClaimedJumpCoil.Value == false then
                        local Status, Response, TextColor3 = RemoteFunction:InvokeServer()
                        NotifyBE:Fire(Response, TextColor3)
                        if Status == true then
                            ConfettiBE:Fire()
                        end
                    end
                end
            end
        end
        task.wait(1)
        Debounce = false
    end)
end

return function(Player : Player)
    local ClaimedJumpCoil = Player:WaitForChild("ClaimedJumpCoil")
    if ClaimedJumpCoil.Value == true then
        TextLabel.Text = "Claimed"
        return
    elseif ClaimedJumpCoil.Value == false then
        InitTouchConnection(Player)
        local CurrentTime = os.time()
        local JoinDate = Player:WaitForChild("JoinDate")
        local Goal = JoinDate.Value + DayInSeconds
        if CurrentTime >= Goal then
            TextLabel.Text = "CLAIM"
        elseif CurrentTime < Goal then
            task.spawn(function()
                for index = Goal-CurrentTime,0,-1 do
                    TextLabel.Text = TimeFormatterModule(index)
                    task.wait(1)
                end
                TextLabel.Text = "CLAIM"
            end)
        end
    end
end