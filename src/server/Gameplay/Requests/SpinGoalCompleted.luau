return function(Player: Player)
	if not Player then
		return
	end
	local SpinGoal = Player:FindFirstChild("SpinGoal")
	if SpinGoal then
		if os.time() >= SpinGoal.Value then
			SpinGoal.Value += 86400
		end
	end
end
