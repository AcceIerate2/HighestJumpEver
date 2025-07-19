return function(Player: Player)
	if not Player then
		return
	end
	local LastDisconnect = Player:FindFirstChild("LastDisconnect")
	if LastDisconnect then
		if LastDisconnect.Value == 0 then
			return
		end

		local CurrentTime = os.time()
		local SecondsSinceLeave = CurrentTime - LastDisconnect.Value
		local AmountToGive = SecondsSinceLeave / 5

		if AmountToGive <= 0 then
			AmountToGive = 1
		end

		local PowerMultiplier = Player:FindFirstChild("PowerMultiplier")
		if PowerMultiplier then
			AmountToGive *= PowerMultiplier.Value
		end

		local HasDoubleOfflineGainPass = Player:FindFirstChild("DoubleOfflineGains")
		if HasDoubleOfflineGainPass then
			if HasDoubleOfflineGainPass.Value == true then
				AmountToGive *= 2
			end
		end

		AmountToGive = math.clamp(AmountToGive, 0, 150000)
		Player:SetAttribute("OfflineReward", AmountToGive)

		local PlayerPower = Player:FindFirstChild("Power")
		if PlayerPower then
			PlayerPower.Value += AmountToGive
		end
	end
end
