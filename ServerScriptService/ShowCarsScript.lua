local cars = game.ReplicatedStorage:WaitForChild("CarsForShopViewport")
local showCarsEvent = game.ReplicatedStorage:WaitForChild("ShowCarsEvent")

game.Players.PlayerAdded:Connect(function(player)
	local carsInventory = player:WaitForChild("CarsInventory")
	
	if cars and showCarsEvent then
		local carsTable = {}			
			
		local blueCar = Instance.new("IntValue", carsInventory)
		blueCar.Name = "BlueCar"
		blueCar.Value = 500
		local blueCarEquipped = Instance.new("BoolValue", blueCar)
		blueCarEquipped.Name  = "CarEquipped"
		blueCarEquipped.Value = false
				
		local blackCar = Instance.new("IntValue", carsInventory)
		blackCar.Name = "BlackCar"
		blackCar.Value = 500
		local blackCarEquipped = Instance.new("BoolValue", blackCar)
		blackCarEquipped.Name  = "CarEquipped"
		blackCarEquipped.Value = false
				
		local redCar = Instance.new("IntValue", carsInventory)
		redCar.Name = "RedCar"
		redCar.Value = 500
		local redCarEquipped = Instance.new("BoolValue", redCar)
		redCarEquipped.Name  = "CarEquipped"
		redCarEquipped.Value = false
		
		
		local violetCar = Instance.new("IntValue", carsInventory)
		violetCar.Name = "VioletCar"
		violetCar.Value = 500
		local violetCarEquipped = Instance.new("BoolValue", violetCar)
		violetCarEquipped.Name  = "CarEquipped"
		violetCarEquipped.Value = false
				
		local yellowCar = Instance.new("IntValue", carsInventory)
		yellowCar.Name = "YellowCar"
		yellowCar.Value = 500
		local yellowCarEquipped = Instance.new("BoolValue", yellowCar)
		yellowCarEquipped.Name  = "CarEquipped"
		yellowCarEquipped.Value = false
							
		for i, v in pairs(carsInventory:GetChildren()) do
			table.insert(carsTable, v.Name)
		end
		
		showCarsEvent:FireClient(player, carsTable)
	end
end)


