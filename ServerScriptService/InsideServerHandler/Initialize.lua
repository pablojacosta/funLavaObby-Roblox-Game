local playerService = game:GetService("Players")
local dataMod = require(script.Parent.Data)
local spawnParts = workspace.SpawnParts

--------------------------------------------------------------------
local initializeMod = {}


local function getStage(stageNum)
	for _, stagePart in pairs(spawnParts:GetChildren()) do
		if stagePart.Stage.Value == stageNum then
			return stagePart
		end
	end
end

playerService.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(char)
		wait()
		
		local stageNum = dataMod.get(player, "Stage")
		local spawnPoint = getStage(stageNum)
		char:SetPrimaryPartCFrame(spawnPoint.CFrame * CFrame.new(0, 3, 0))
	end)
end)





return initializeMod