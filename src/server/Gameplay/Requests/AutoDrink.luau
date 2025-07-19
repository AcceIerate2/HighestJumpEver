return function(Player : Player) : boolean
    if Player.AutoDrink.Value == true then
        Player.AutoDrinkEnabled.Value = not Player.AutoDrinkEnabled.Value
    end
    return Player.AutoDrink.Value
end