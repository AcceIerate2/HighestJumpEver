local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteFunction = ReplicatedStorage:WaitForChild("Events"):WaitForChild("RemoteFunctions"):WaitForChild("ClaimDailyReward")
local NotifyBE = ReplicatedStorage:WaitForChild("Events"):WaitForChild("BindableEvents"):WaitForChild("Notify")
local TimeFormatterModule = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("FormatTime"))
return function(Button : GuiButton, Player : Player, PlayerGui : PlayerGui)
    local Status, Response, TextColor3 = RemoteFunction:InvokeServer(Button)
    NotifyBE:Fire(Response, TextColor3)
    if Status == true then
        local CanvasGroup = Button.Parent
        CanvasGroup:WaitForChild("UIStroke").Color = Color3.fromRGB(0,0,0)
        Button:WaitForChild("Checkmark").Visible = true
        ReplicatedStorage:WaitForChild("Events"):WaitForChild("BindableEvents"):WaitForChild("Confetti"):Fire()
        CanvasGroup:FindFirstChildOfClass("ImageButton"):WaitForChild("Day").Text = "Day "..CanvasGroup.Name
        local NextCanvasGroup = CanvasGroup.Parent:FindFirstChild(tonumber(CanvasGroup.Name) + 1)
        if NextCanvasGroup then
            NextCanvasGroup.GroupColor3 = Color3.fromRGB(255,255,255)
            NextCanvasGroup:WaitForChild("UIStroke").Color = Color3.fromRGB(255,255,255)
            task.spawn(function()
                for index = Player:WaitForChild("DailyRewardGoal").Value - os.time(),0,-1 do
                    NextCanvasGroup:FindFirstChildOfClass("ImageButton"):WaitForChild("Day").Text = TimeFormatterModule(index)
                    task.wait(1)
                end
                NextCanvasGroup:FindFirstChildOfClass("ImageButton"):WaitForChild("Day").Text = "Claim"
                if NextCanvasGroup:WaitForChild("ImageButton"):WaitForChild("Checkmark").Visible == true then
                    NextCanvasGroup:FindFirstChildOfClass("ImageButton"):WaitForChild("Day").Text = "Day "..NextCanvasGroup.Name
                end
            end)
        end
    end
end