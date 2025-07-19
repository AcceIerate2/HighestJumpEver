local AnimationObjects = script.Parent.Parent.AnimationObjects
return function(Player : Player, Name : string, Load : boolean)
    if not Player or not Name then return false end
    local Character = Player.Character
    if Character and Character:IsA("Model") then
        local Humanoid = Character:FindFirstChild("Humanoid")
        if Humanoid then
            local Animator = Humanoid:FindFirstChild("Animator")
            if Animator then
                local AnimationObjectIfAny = AnimationObjects:FindFirstChild(Name)
                if AnimationObjectIfAny then
                    local LoadedAnimation = Animator:LoadAnimation(AnimationObjectIfAny)
                    if LoadedAnimation then
                        if Load and typeof(Load) == "boolean" and Load == true then
                            LoadedAnimation:Destroy()
                            return true
                        end
                        local IsLooped = LoadedAnimation.Looped :: boolean
                        if IsLooped == true then
                            LoadedAnimation:Play()
                            local Duration = AnimationObjectIfAny:GetAttribute("Duration")
                            if Duration and typeof(Duration) == "number" then
                                task.wait(Duration)
                                LoadedAnimation:Stop()
                                LoadedAnimation:Destroy()
                                return true
                            end
                        elseif IsLooped == false then
                            LoadedAnimation:Play()
                            task.spawn(function()
                                LoadedAnimation.Ended:Wait()
                                LoadedAnimation:Destroy()
                                return 
                            end)
                            return true
                        end
                    end
                end
            end
        end
    end
    return false
end