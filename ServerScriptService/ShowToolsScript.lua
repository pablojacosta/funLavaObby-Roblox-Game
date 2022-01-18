local tools = game.ReplicatedStorage:WaitForChild("ToolsForShopViewport")
local showPotionsEvent = game.ReplicatedStorage:WaitForChild("ShowPotionsEvent")

game.Players.PlayerAdded:Connect(function(player)
	local potionsInventory = player:WaitForChild("PotionsInventory")
	
	if tools and showPotionsEvent then
		local potionsTable = {}			
		
		local healthPotion = Instance.new("IntValue", potionsInventory)
		healthPotion.Name = "HealthPotion"
		healthPotion.Value = 300
		local healthPotionEquipped = Instance.new("BoolValue", healthPotion)
		healthPotionEquipped.Name = "PotionEquipped"
		healthPotionEquipped.Value = false		
		
		local speedPotion = Instance.new("IntValue", potionsInventory)
		speedPotion.Name = "SpeedPotion"
		speedPotion.Value = 150
		local speedPotionEquipped = Instance.new("BoolValue", speedPotion)
		speedPotionEquipped.Name = "PotionEquipped"
		speedPotionEquipped.Value = false	
		
		local springPotion = Instance.new("IntValue", potionsInventory)
		springPotion.Name = "SpringPotion"
		springPotion.Value = 150
		
		for i, v in pairs(potionsInventory:GetChildren()) do
			table.insert(potionsTable, v.Name)
		end

		showPotionsEvent:FireClient(player, potionsTable)
	end
end)


