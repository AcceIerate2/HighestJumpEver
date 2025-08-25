local HttpService = game:GetService("HttpService")
local Module = {}

Module.WEB_SERVER_URL = "https://bloxpulsedbserver.pythonanywhere.com/schedule"
Module.universeId = 7549141947
Module.api_key = require(script.API_KEY)

function Module.Push(player: Player | number, message: string)
	local userId = typeof(player) == "Instance" and player:IsA("Player") and player.UserId or player :: number

	local data = {
		["universeId"] = tostring(Module.universeId),
		["notificationId"] = "b0b7d58f-8eac-6f4c-8014-7f8375fe67c9",
		["key"] = tostring(userId),
		["time"] = os.time() + 86400,
		["message"] = message,
		["api_key"] = Module.api_key,
	}

	task.spawn(function()
		for _index: number = 3, 1, -1 do
			local status, response = pcall(function()
				HttpService:PostAsync(
					Module.WEB_SERVER_URL,
					HttpService:JSONEncode(data),
					Enum.HttpContentType.ApplicationJson
				)
			end)

			if not status then
				warn(response)
			else
				print("Pushed Notification Request to web Server.")
				break
			end
			task.wait(2)
		end
	end)
end

return Module
