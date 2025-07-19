local SaveThreadModule = require(script.Parent.SaveThreads)
local DataRequestsModule = require(script.Parent.DataRequests)
return function(Player: Player)
	local LastDisconnect = Player:FindFirstChild("LastDisconnect")
	if LastDisconnect then
		LastDisconnect.Value = os.time()
	end
	if SaveThreadModule[Player.UserId] then
		if typeof(SaveThreadModule[Player.UserId]) == "thread" then
			task.cancel(SaveThreadModule[Player.UserId])
		end
		SaveThreadModule[Player.UserId] = nil
	end
	local Saved = DataRequestsModule("Save", Player)
	if typeof(Saved) == "boolean" and Saved == true then
		print("Saved Data for Player: " .. Player.Name)
	end
end
