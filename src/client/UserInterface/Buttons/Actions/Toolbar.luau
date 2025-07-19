local ToolbarModule = require(script.Parent.Parent.Parent.Parent:WaitForChild("Toolbar"))
return function(Button : GuiButton, Player : Player, PlayerGui : PlayerGui)
    ToolbarModule(Button.Name)
end