local dataMod = require(game.ServerScriptService.ServerHandler.Data)

local function showLabel(label)
	label.Visible = true
	wait(2)
	label.Visible = false
end

game.ReplicatedStorage.ToolsEvents.SpringPotionEvent.OnServerEvent:Connect(function(player)
	local price = player:WaitForChild("PotionsInventory"):FindFirstChild("SpringPotion").Value
	
	if player.leaderstats.Coins.Value >= price then
		
		dataMod.increment(player, "Coins", - price)
		game.ServerStorage.Tools.SpringPotion:Clone().Parent = player.Backpack
		
	end
end)

game.ReplicatedStorage.ToolsEvents.SpeedPotionEvent.OnServerEvent:Connect(function(player)
	local price = player:WaitForChild("PotionsInventory"):FindFirstChild("SpeedPotion").Value
	
	if player.leaderstats.Coins.Value >= price then
		
		dataMod.increment(player, "Coins", - price)
		game.ServerStorage.Tools.SpeedPotion:Clone().Parent = player.Backpack
		
	end
end)

game.ReplicatedStorage.ToolsEvents.HealthPotionEvent.OnServerEvent:Connect(function(player)
	local price = player:WaitForChild("PotionsInventory"):FindFirstChild("HealthPotion").Value
	
	if player.leaderstats.Coins.Value >= price then
		
		dataMod.increment(player, "Coins", - price)
		game.ServerStorage.Tools.HealthPotion:Clone().Parent = player.Backpack
		
	end
end)

