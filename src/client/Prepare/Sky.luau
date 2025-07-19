local SoundService = game:GetService("SoundService")
local WarpSFX = SoundService:WaitForChild("Warp")
local Lighting = game:GetService("Lighting")
local Skies = Lighting:WaitForChild("Skies")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UpdateSkyRE = ReplicatedStorage:WaitForChild("Events"):WaitForChild("RemoteEvents"):WaitForChild("UpdateSky")
local _SkyConnection = nil

local function StopAllMusic()
	for _index, v in pairs(SoundService:WaitForChild("Music"):GetChildren()) do
		v:Stop()
	end
end

return function(_Player: Player)
	_SkyConnection = UpdateSkyRE.OnClientEvent:Connect(function(ZoneData: {})
		if ZoneData == nil then
			return
		end
		local DeleteSkyIfAny = Lighting:FindFirstChildOfClass("Sky")
		if DeleteSkyIfAny then
			DeleteSkyIfAny:Destroy()
		end
		local Sky = Skies:FindFirstChild(ZoneData[2])
		if Sky then
			StopAllMusic()
			local Music = SoundService:WaitForChild("Music"):FindFirstChild(ZoneData[2])
			if Music then
				Music:Play()
				if Music.Name == "Echo Peak" then
					task.delay(3, function()
						Music.Playing = true
						Music:Play()
					end)
				end
			end
			local SoundEffect = SoundService:WaitForChild("Sounds"):FindFirstChild(ZoneData[2])
			if SoundEffect then
				SoundEffect:Play()
			end
			WarpSFX:Play()
			local ClonedSky = Sky:Clone()
			ClonedSky.Parent = Lighting

			local Sunrays = Lighting:FindFirstChild("SunRays")
			if Sunrays then
				if ZoneData[1] >= 225000 then
					Sunrays.Enabled = false
				else
					Sunrays.Enabled = true
				end
			end
		end
	end)
end
