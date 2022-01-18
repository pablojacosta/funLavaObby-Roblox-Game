	local dataMod = require(game.ServerScriptService.ServerHandler.Data)

	local function showLabel(label)
		label.Visible = true
		wait(2)
		label.Visible = false
	end


	game.ReplicatedStorage.CarsEvents.BlueCarEvent.OnServerEvent:Connect(function(player)
		local price = player:WaitForChild("CarsInventory"):FindFirstChild("BlueCar").Value
		local label = player:WaitForChild("PlayerGui"):WaitForChild("CarShop"):WaitForChild("Cars"):FindFirstChild("AlreadyHasCarLabel")
			
		if player.leaderstats.Coins.Value >= price then
			if player:WaitForChild("CarsInventory"):FindFirstChild("BlueCar").CarEquipped.Value == false and 
				player:WaitForChild("CarsInventory"):FindFirstChild("BlackCar").CarEquipped.Value == false and
				player:WaitForChild("CarsInventory"):FindFirstChild("RedCar").CarEquipped.Value == false and
				player:WaitForChild("CarsInventory"):FindFirstChild("VioletCar").CarEquipped.Value == false and
				player:WaitForChild("CarsInventory"):FindFirstChild("YellowCar").CarEquipped.Value == false
			then
				local cloneBlueCar = game.ServerStorage.Cars.BlueCar:Clone()
				local blueCarFolder = Instance.new("Folder", workspace)
				blueCarFolder.Name = player.Name.."'s BlueCar"
				player:WaitForChild("CarsInventory"):FindFirstChild("BlueCar").CarEquipped.Value = true
				dataMod.increment(player, "Coins", - price)
				cloneBlueCar.Parent = workspace
				--make model appear behind character
				cloneBlueCar:PivotTo(player.Character:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(0, 0, 8))
				--move everything inside model to folder, because if not car won't work
				for i, v in pairs(cloneBlueCar:GetChildren()) do
					v.Parent = blueCarFolder
				end
				--to set car owner
				game.Workspace:WaitForChild(player.Name.."'s BlueCar"):WaitForChild("Owner").Value = player.Name
				cloneBlueCar:Destroy()
			else
				showLabel(label)
			end
		end
	end)

	game.ReplicatedStorage.CarsEvents.BlackCarEvent.OnServerEvent:Connect(function(player)
		local price = player:WaitForChild("CarsInventory"):FindFirstChild("BlackCar").Value
		local label = player:WaitForChild("PlayerGui"):WaitForChild("CarShop"):WaitForChild("Cars"):FindFirstChild("AlreadyHasCarLabel")
		
		if player.leaderstats.Coins.Value >= price then
			if player:WaitForChild("CarsInventory"):FindFirstChild("BlueCar").CarEquipped.Value == false and 
				player:WaitForChild("CarsInventory"):FindFirstChild("BlackCar").CarEquipped.Value == false and
				player:WaitForChild("CarsInventory"):FindFirstChild("RedCar").CarEquipped.Value == false and
				player:WaitForChild("CarsInventory"):FindFirstChild("VioletCar").CarEquipped.Value == false and
				player:WaitForChild("CarsInventory"):FindFirstChild("YellowCar").CarEquipped.Value == false
			then
				local cloneBlackCar = game.ServerStorage.Cars.BlackCar:Clone()
				local blackCarFolder = Instance.new("Folder", workspace)
				blackCarFolder.Name = player.Name.."'s BlackCar"
				player:WaitForChild("CarsInventory"):FindFirstChild("BlackCar").CarEquipped.Value = true
				dataMod.increment(player, "Coins", - price)
				cloneBlackCar.Parent = workspace
				cloneBlackCar:PivotTo(player.Character:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(0, 0, 8))
				for i, v in pairs(cloneBlackCar:GetChildren()) do
					v.Parent = blackCarFolder
				end
				game.Workspace:WaitForChild(player.Name.."'s BlackCar"):WaitForChild("Owner").Value = player.Name
				cloneBlackCar:Destroy()
			else
				showLabel(label)
			end
		end
	end)

	game.ReplicatedStorage.CarsEvents.RedCarEvent.OnServerEvent:Connect(function(player)
		local price = player:WaitForChild("CarsInventory"):FindFirstChild("RedCar").Value
		local label = player:WaitForChild("PlayerGui"):WaitForChild("CarShop"):WaitForChild("Cars"):FindFirstChild("AlreadyHasCarLabel")
		
		if player.leaderstats.Coins.Value >= price then
			if player:WaitForChild("CarsInventory"):FindFirstChild("BlueCar").CarEquipped.Value == false and 
				player:WaitForChild("CarsInventory"):FindFirstChild("BlackCar").CarEquipped.Value == false and
				player:WaitForChild("CarsInventory"):FindFirstChild("RedCar").CarEquipped.Value == false and
				player:WaitForChild("CarsInventory"):FindFirstChild("VioletCar").CarEquipped.Value == false and
				player:WaitForChild("CarsInventory"):FindFirstChild("YellowCar").CarEquipped.Value == false
			then
				local cloneRedCar = game.ServerStorage.Cars.RedCar:Clone()
				local redCarFolder = Instance.new("Folder", workspace)
				redCarFolder.Name = player.Name.."'s RedCar"
				player:WaitForChild("CarsInventory"):FindFirstChild("RedCar").CarEquipped.Value = true
				dataMod.increment(player, "Coins", - price)
				cloneRedCar.Parent = workspace
				cloneRedCar:PivotTo(player.Character:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(0, 0, 8))
				for i, v in pairs(cloneRedCar:GetChildren()) do
					v.Parent = redCarFolder
				end
				game.Workspace:WaitForChild(player.Name.."'s RedCar"):WaitForChild("Owner").Value = player.Name
				cloneRedCar:Destroy()
			else
				showLabel(label)
			end
		end
	end)

	game.ReplicatedStorage.CarsEvents.VioletCarEvent.OnServerEvent:Connect(function(player)
		local price = player:WaitForChild("CarsInventory"):FindFirstChild("VioletCar").Value
		local label = player:WaitForChild("PlayerGui"):WaitForChild("CarShop"):WaitForChild("Cars"):FindFirstChild("AlreadyHasCarLabel")
		
		if player.leaderstats.Coins.Value >= price then
			if player:WaitForChild("CarsInventory"):FindFirstChild("BlueCar").CarEquipped.Value == false and 
				player:WaitForChild("CarsInventory"):FindFirstChild("BlackCar").CarEquipped.Value == false and
				player:WaitForChild("CarsInventory"):FindFirstChild("RedCar").CarEquipped.Value == false and
				player:WaitForChild("CarsInventory"):FindFirstChild("VioletCar").CarEquipped.Value == false and
				player:WaitForChild("CarsInventory"):FindFirstChild("YellowCar").CarEquipped.Value == false
			then
				local cloneVioletCar = game.ServerStorage.Cars.VioletCar:Clone()
				local violetCarFolder = Instance.new("Folder", workspace)
				violetCarFolder.Name = player.Name.."'s VioletCar"
				player:WaitForChild("CarsInventory"):FindFirstChild("VioletCar").CarEquipped.Value = true
				dataMod.increment(player, "Coins", - price)
				cloneVioletCar.Parent = workspace
				cloneVioletCar:PivotTo(player.Character:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(0, 0, 8))
				for i, v in pairs(cloneVioletCar:GetChildren()) do
					v.Parent = violetCarFolder
				end
				game.Workspace:WaitForChild(player.Name.."'s VioletCar"):WaitForChild("Owner").Value = player.Name
				cloneVioletCar:Destroy()
			else
				showLabel(label)
			end
		end
	end)

	game.ReplicatedStorage.CarsEvents.YellowCarEvent.OnServerEvent:Connect(function(player)
		local price = player:WaitForChild("CarsInventory"):FindFirstChild("YellowCar").Value
		local label = player:WaitForChild("PlayerGui"):WaitForChild("CarShop"):WaitForChild("Cars"):FindFirstChild("AlreadyHasCarLabel")
		
		if player.leaderstats.Coins.Value >= price then
			if player:WaitForChild("CarsInventory"):FindFirstChild("BlueCar").CarEquipped.Value == false and 
				player:WaitForChild("CarsInventory"):FindFirstChild("BlackCar").CarEquipped.Value == false and
				player:WaitForChild("CarsInventory"):FindFirstChild("RedCar").CarEquipped.Value == false and
				player:WaitForChild("CarsInventory"):FindFirstChild("VioletCar").CarEquipped.Value == false and
				player:WaitForChild("CarsInventory"):FindFirstChild("YellowCar").CarEquipped.Value == false
			then
				local cloneYellowCar = game.ServerStorage.Cars.YellowCar:Clone()
				local yellowCarFolder = Instance.new("Folder", workspace)
				yellowCarFolder.Name = player.Name.."'s YellowCar"
				player:WaitForChild("CarsInventory"):FindFirstChild("YellowCar").CarEquipped.Value = true
				dataMod.increment(player, "Coins", - price)
				cloneYellowCar.Parent = workspace
				cloneYellowCar:PivotTo(player.Character:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(0, 0, 8))
				for i, v in pairs(cloneYellowCar:GetChildren()) do
					v.Parent = yellowCarFolder
				end
				game.Workspace:WaitForChild(player.Name.."'s YellowCar"):WaitForChild("Owner").Value = player.Name
				cloneYellowCar:Destroy()
			else
				showLabel(label)
			end
		end
	end)

	game.ReplicatedStorage:WaitForChild("CarsEvents"):FindFirstChild("BlackCarUnequip").OnServerEvent:Connect(function(player)
		player:WaitForChild("CarsInventory"):FindFirstChild("BlackCar"):FindFirstChild("CarEquipped").Value = false
		workspace:WaitForChild(player.Name.."'s BlackCar"):Destroy()
	end)

	game.ReplicatedStorage:WaitForChild("CarsEvents"):FindFirstChild("BlueCarUnequip").OnServerEvent:Connect(function(player)
		player:WaitForChild("CarsInventory"):FindFirstChild("BlueCar"):FindFirstChild("CarEquipped").Value = false
		workspace:WaitForChild(player.Name.."'s BlueCar"):Destroy()
	end)

	game.ReplicatedStorage:WaitForChild("CarsEvents"):FindFirstChild("RedCarUnequip").OnServerEvent:Connect(function(player)
		player:WaitForChild("CarsInventory"):FindFirstChild("RedCar"):FindFirstChild("CarEquipped").Value = false
		workspace:WaitForChild(player.Name.."'s RedCar"):Destroy()
	end)

	game.ReplicatedStorage:WaitForChild("CarsEvents"):FindFirstChild("VioletCarUnequip").OnServerEvent:Connect(function(player)
		player:WaitForChild("CarsInventory"):FindFirstChild("VioletCar"):FindFirstChild("CarEquipped").Value = false
		workspace:WaitForChild(player.Name.."'s VioletCar"):Destroy()
	end)

	game.ReplicatedStorage:WaitForChild("CarsEvents"):FindFirstChild("YellowCarUnequip").OnServerEvent:Connect(function(player)
		player:WaitForChild("CarsInventory"):FindFirstChild("YellowCar"):FindFirstChild("CarEquipped").Value = false
		workspace:WaitForChild(player.Name.."'s YellowCar"):Destroy()
	end)

