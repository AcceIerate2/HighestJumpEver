local ExperienceNotificationService = game:GetService("ExperienceNotificationService")
local GuiService = game:GetService("GuiService")
local SoundService = game:GetService("SoundService")

local ActiveThread = nil :: thread | nil
local Connection = nil

local function CanReceiveNotifications(): boolean
	local Can = false
	for _Index = 3, 1, -1 do
		local Status, Response = pcall(function()
			return ExperienceNotificationService:CanPromptOptInAsync()
		end)
		if Status == false then
			warn(Response)
			task.wait(1)
		elseif Status == true then
			Can = Response
		end
	end
	return Can
end

local function PromptIn()
	for _Index = 3, 1, -1 do
		local Status, Response = pcall(function()
			return ExperienceNotificationService:PromptOptIn()
		end)
		if Status == false then
			warn(Response)
			task.wait(1)
		elseif Status == true then
			SoundService:WaitForChild("PromptIn"):Play()
			break
		end
	end
end

local function Countdown()
	for _Index = 600, 1, -1 do
		task.wait(1)
	end
end

return function(Player: Player)
	if not Player then
		return
	end
	local _CanReceiveNotifications = CanReceiveNotifications() :: boolean
	if _CanReceiveNotifications then
		ActiveThread = task.spawn(Countdown)
		Connection = GuiService.MenuOpened:Once(function()
			if typeof(ActiveThread) == "thread" then
				task.cancel(ActiveThread)
				ActiveThread = nil
			end
			Connection:Disconnect()
			Connection = nil
			PromptIn()
		end)
	end
end
