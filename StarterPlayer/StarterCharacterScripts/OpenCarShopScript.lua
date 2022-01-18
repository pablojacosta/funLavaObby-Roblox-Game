local carsShop = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui').CarShop.Cars
local openShopCircle = game.Workspace.ModelParts.CarShop.Circle
local player = game:GetService("Players").LocalPlayer
local db = true

openShopCircle.Touched:Connect(function(other)
	if db == true then
		db = false
		carsShop.Visible = other:IsDescendantOf(player.Character)
		wait(3)
		db = true
	end
end)

