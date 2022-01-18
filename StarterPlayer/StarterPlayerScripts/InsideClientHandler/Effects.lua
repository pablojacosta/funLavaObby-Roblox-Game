local replicatedStorage = game:GetService("ReplicatedStorage")
local effectsEvent = game.ReplicatedStorage:WaitForChild("Effects") 

local effectsMod = {}

-------------------------------------------------------------------------------
local function playSound(part)
	local sound = part:FindFirstChildOfClass("Sound")
	
	if sound then
		sound:Play()
	end
	
	return sound
end

-------------------------------------------------------------------------------
local function emitParticles(part, amount)
	local emitter = part:FindFirstChildOfClass("ParticleEmitter")
	
	if emitter then
		emitter:Emit(amount)
	end
	
	return emitter
end

--to connect client side from server with touched parts to play sound/emit particles 
effectsEvent.OnClientEvent:Connect(function(part)
	local folderName = part.Parent.Name
	effectsMod[folderName](part)
end)

effectsMod.RewardParts = function(part)
	emitParticles(part, 10)
	part.Material = Enum.Material.Neon

	delay(1, function()
		part.Material = Enum.Material.SmoothPlastic
	end)
	part.Transparency = 1
	part.PointLight.Enabled = false
	playSound(part)
end

effectsMod.SpawnParts = function(part)
	playSound(part)
	emitParticles(part, 50)
	part.Material = Enum.Material.Neon

	delay(1, function()
		part.Material = Enum.Material.SmoothPlastic
	end)
end

--to give movement to parts------------------------------------------------------
local runService = game:GetService("RunService")

local rotParts = {}

local partGroups = {
	workspace.KillParts;
	workspace.DamageParts;
	workspace.SpawnParts;
	workspace.RewardParts;
	workspace.BadgeParts;
	workspace.PurchaseParts;
	workspace.ShopParts;
	workspace.LaserParts;
	workspace.FadingParts;
	workspace.MovingParts;
	workspace.SitParts;
	workspace.MovingLaserParts;
	workspace.MovingParts2;
	workspace.RotatingParts;
}

for _, group in pairs(partGroups) do
	for _, part in pairs(group:GetChildren()) do
		if part:IsA("BasePart") then
			if part:FindFirstChild("Rotate") then
				table.insert(rotParts, part)
			end
		end
	end
end

runService.RenderStepped:Connect(function(dt)
	for _, part in pairs(rotParts) do
		local rot = part.Rotate.Value
		rot = rot * dt
		rot = rot * ((2 * math.pi) / 360)
		rot = CFrame.Angles(rot.X, rot.Y, rot.Z)
		
		part.CFrame = part.CFrame * rot
	end
	
end)

return effectsMod