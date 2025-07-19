local CanvasTogglerModule = require(script:WaitForChild("CanvasToggler"))
return function(Button : GuiButton, Player : Player, PlayerGui : PlayerGui)
    local Name = Button.Name
    local CustomNameIfAny = Button:GetAttribute("Name")
    if CustomNameIfAny and typeof(CustomNameIfAny) == "string" and #CustomNameIfAny > 0 then
        Name = CustomNameIfAny
    end
    local CustomSectionIfAny = Button:GetAttribute("Section")
    CanvasTogglerModule(Name, CustomSectionIfAny)
end