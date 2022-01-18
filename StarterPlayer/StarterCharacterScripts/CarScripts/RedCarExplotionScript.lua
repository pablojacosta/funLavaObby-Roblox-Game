game.ReplicatedStorage:WaitForChild("CarsEvents"):FindFirstChild("RedCarExplotionEnabled").OnClientEvent:Connect(function(playerName)
	local explosionPart = workspace:WaitForChild(playerName.."'s RedCar"):FindFirstChild("ExplosionPart")
	local isOccupied = workspace:WaitForChild(playerName.."'s RedCar"):FindFirstChild("Occupied")
	
	if playerName then
		explosionPart.Touched:Connect(function(part)
			local explosion = Instance.new("Explosion")
			
			if part.Name ~= "coinPart" and part.Name ~= "gemPart" then
				if isOccupied.Value == true then
					explosion.BlastRadius = 10
					explosion.BlastPressure = 50000 -- no damage, just explosion
					explosion.Position = explosionPart.Position
					--explosion.ExplosionType = Enum.ExplosionType.NoCraters -- no damage
					explosion.DestroyJointRadiusPercent = 10 -- no damage

					explosion.Parent = explosionPart
					wait(1)
					game.Workspace:WaitForChild(playerName.."'s RedCar"):ClearAllChildren()
					game.Workspace:FindFirstChild(playerName.."'s RedCar"):Destroy()
					game.ReplicatedStorage:WaitForChild("CarsEvents"):FindFirstChild("RedCarUnequip"):FireServer()
				end
			end
		end)
	end
end)
