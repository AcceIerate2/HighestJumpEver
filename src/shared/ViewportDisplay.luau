local function ResetViewportFrame(ViewportFrame : ViewportFrame)
    for Index, Child in pairs(ViewportFrame:GetChildren()) do
        if Child:IsA("Tool") or Child:IsA("Model") or Child:IsA("BasePart") then
            Child:Destroy()
        end
    end
end
return function(Model : Model | Tool, ViewportFrame : ViewportFrame)
    ResetViewportFrame(ViewportFrame)
    local NewModel = Model:Clone()
    NewModel:PivotTo(CFrame.new(0,0,0))
    NewModel.Parent = ViewportFrame
end