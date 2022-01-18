local CollectionService = game:GetService("CollectionService")
local teleportPads = CollectionService:GetTagged("Telepads")
local base1 = game.Workspace.TeletransportParts.Teletransport1.Beam.base1
local base2 = game.Workspace.TeletransportParts.Teletransport2.Beam.base2
local base3 = game.Workspace.TeletransportParts.Teletransport3.Beam.base3
local base4 = game.Workspace.TeletransportParts.Teletransport4.Beam.base4
local db = true

for _, taggedPart in pairs(teleportPads) do

	taggedPart.Touched:Connect(function(hit)
		local char = hit.Parent
		local root = char:FindFirstChild("HumanoidRootPart")
		if root and db then
			if taggedPart.Name == "base1" then
				wait(0.5)
				db = false
				root.CFrame = base2.CFrame + Vector3.new(0,5,0) 
			elseif taggedPart.Name == "base2" then
				wait(0.5)
				db = false
				root.CFrame = base1.CFrame + Vector3.new(0,5,0) 
			elseif taggedPart.Name == "base3" then
				wait(0.5)
				db = false
				root.CFrame = base4.CFrame + Vector3.new(0,5,0)
			elseif taggedPart.Name == "base4" then
				wait(0.5)
				db = false
				root.CFrame = base3.CFrame + Vector3.new(0,5,0)
			end
		end
			wait(3)
			db = true
	end)
end

