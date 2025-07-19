local ActionTypes = {
    ["Toolbar"] = require(script:WaitForChild("Toolbar")),
    ["Rebirth"] = require(script:WaitForChild("Rebirth")),
    ["Prestige"] = require(script:WaitForChild("Prestige")),
    ["Upgrade"] = require(script:WaitForChild("Upgrade")),
    ["UpgradeSelection"] = require(script:WaitForChild("UpgradeSelection")),
    ["EndJump"] = require(script:WaitForChild("EndJump")),
    ["DrinkSelection"] = require(script:WaitForChild("DrinkSelection")),
    ["Purchase"] = require(script:WaitForChild("Purchase")),
    ["ShopSelection"] = require(script:WaitForChild("ShopSelection")),
    ["ToggleLeaderstats"] = require(script:WaitForChild("ToggleLeaderstats")),
    ["FreeReward"] = require(script:WaitForChild("FreeReward")),
    ["AutoDrink"] = require(script:WaitForChild("AutoDrink")),
    ["TutorialPage"] = require(script:WaitForChild("TutorialPage")),
    ["ClaimDailyReward"] = require(script:WaitForChild("ClaimDailyReward"))
}

return function(Button : GuiButton, Player : Player, PlayerGui : PlayerGui)
    if not Button or not Player or not PlayerGui then return end
    local ActionType = Button:GetAttribute("Action")
    local FunctionIfAny = ActionTypes[ActionType]
    if FunctionIfAny then
        FunctionIfAny(Button, Player, PlayerGui)
    end
end
