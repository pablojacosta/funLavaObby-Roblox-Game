local dataMod = require(script.Parent.Data)
local playerService = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local effectsEvent = game.ReplicatedStorage:WaitForChild("Effects")

---------------------------------------------------------------

local partFunctionsMod = {}


local TweenService = game:GetService("TweenService")

local function setTweenTime()
	for i, eachPart in pairs(workspace.MovingParts:GetChildren()) do
		local tweenTime = Instance.new("IntValue", eachPart)
		tweenTime.Name = "TweenTime"
		tweenTime.Value = i
	end
end

local function setTweenTime2()
	for i, eachPart in pairs(workspace.MovingParts2:GetChildren()) do
		local tweenTime = Instance.new("IntValue", eachPart)
		tweenTime.Name = "TweenTime"
		tweenTime.Value = i
	end
end

local function setTweenTime3()
	for i, eachPart in pairs(workspace.RotatingParts:GetChildren()) do
		local tweenTime = Instance.new("IntValue", eachPart)
		tweenTime.Name = "TweenTime"
		tweenTime.Value = i
	end
end


---------------------------------------------------------------------------------------------
function partFunctionsMod.playerFromHit(hit)
	local char = hit:FindFirstAncestorOfClass("Model")
	local player = playerService:GetPlayerFromCharacter(char)
	return player, char
end

---------------------------------------------------------------------------------------------
function partFunctionsMod.KillParts(part)
	part.Touched:Connect(function(hit)
		local player, char = partFunctionsMod.playerFromHit(hit)
		if player and char.Humanoid.Health > 0 then
			char.Humanoid.Health = 0
		end
	end)
end

----------------------------------------------------------------------------------------------
function partFunctionsMod.DamageParts(part)
	local debounce = false	
	local damage = part.Damage.Value
	
	part.Touched:Connect(function(hit)
		local player, char = partFunctionsMod.playerFromHit(hit)
		if player and not debounce then
			debounce = true
			local hum = char.Humanoid
			hum.Health = hum.Health - damage
			delay(0.1, function()
				debounce = false
			end)
			
		end
	end)
end

----------------------------------------------------------------------------------------------
function partFunctionsMod.LaserParts(part)
	local collisionBox	= part:FindFirstChild("CollisionBox")
	--Hide the Collision Box
	collisionBox.Transparency = 1
	
	collisionBox.Touched:Connect(function(hit)
		local player, char = partFunctionsMod.playerFromHit(hit)
		if player then
			local hum = char:FindFirstChildWhichIsA("Humanoid")
			if hum then
				hum.Health = 0
			end
		end
	end)
end

----------------------------------------------------------------------------------------------
function partFunctionsMod.FadingParts(part)
	local isTouched = false
			
	part.Touched:Connect(function()
		if not isTouched then
			isTouched = true
			for count = 1, 10  do
				part.Transparency = count / 10
				wait(0.1)			
			end
			part.CanCollide = false
			wait(3)
			part.CanCollide = true
			part.Transparency = 0
			isTouched = false
		end
	end)
end

----------------------------------------------------------------------------------------------
function partFunctionsMod.MovingParts(part)
	setTweenTime()
	local tweenTime = 3 + part:WaitForChild("TweenTime").Value
	local tweenInfo = TweenInfo.new(
		tweenTime, -- Time
		Enum.EasingStyle.Linear, -- EasingStyle
		Enum.EasingDirection.Out, -- EasingDirection
		-1, -- RepeatCount (when less than zero the tween will loop indefinitely)
		true, -- Reverses (tween will reverse once reaching it's goal)
		0 -- DelayTime
	)

	local tween = TweenService:Create(part, tweenInfo, {Position = part.Position + Vector3.new(10, 0, 0)})

	tween:Play()
end

----------------------------------------------------------------------------------------------

function partFunctionsMod.SitParts(part)
	part.Touched:Connect(function(hit)
		local player, char = partFunctionsMod.playerFromHit(hit)
		local hum = char:FindFirstChild("Humanoid")
		if hum then
			if part.Name =="sitTriggerPart" then
				hum.Sit = true
			else
				hum.Sit = false
			end
		end
	end)
end

----------------------------------------------------------------------------------------------
function partFunctionsMod.MovingLaserParts(part)
	local debounce = false
	local collisionBox	= part:FindFirstChild("CollisionBox")
	collisionBox.Transparency = 1
	
	local tweenTime = 3
	local tweenInfo = TweenInfo.new(
		tweenTime, -- Time
		Enum.EasingStyle.Linear, -- EasingStyle
		Enum.EasingDirection.Out, -- EasingDirection
		-1, -- RepeatCount (when less than zero the tween will loop indefinitely)
		true, -- Reverses (tween will reverse once reaching it's goal)
		0 -- DelayTime
	)

	local tween = TweenService:Create(part, tweenInfo, {Position = part.Position + Vector3.new(0, -5, 0)})
	
	tween:Play()

	collisionBox.Touched:Connect(function(hit)
		local player, char = partFunctionsMod.playerFromHit(hit)
		if player then
			local hum = char:FindFirstChildWhichIsA("Humanoid")
			if hum then
				hum.Health = 0
			end
		end
	end)
end

----------------------------------------------------------------------------------------------
function partFunctionsMod.MovingParts2(part)
	setTweenTime2()
	local tweenTime = 3 + part:WaitForChild("TweenTime").Value
	local tweenInfo = TweenInfo.new(
		tweenTime, -- Time
		Enum.EasingStyle.Linear, -- EasingStyle
		Enum.EasingDirection.Out, -- EasingDirection
		-1, -- RepeatCount (when less than zero the tween will loop indefinitely)
		true, -- Reverses (tween will reverse once reaching it's goal)
		0 -- DelayTime
	)

	local tween = TweenService:Create(part, tweenInfo, {Position = part.Position + Vector3.new(10, 0, 0)})

	tween:Play()
end



--for checkpoint parts------------------------------------------------------------------------
function partFunctionsMod.SpawnParts(part)
	local stage = part.Stage.Value
		
	part.Touched:Connect(function(hit)
		local player, char = partFunctionsMod.playerFromHit(hit)
		if player and dataMod.get(player, "Stage") == stage - 1 then
			dataMod.set(player, "Stage", stage)
			--to connect with effect in the client side
			effectsEvent:FireClient(player, part)
		end 		
	end)
end

--for reward(coins) parts----------------------------------------------------------------------

local uniqueCode = 0

function partFunctionsMod.RewardParts(part)
	local reward = part.Reward.Value
	local code = uniqueCode
	uniqueCode = uniqueCode + 1
	
	part.Touched:Connect(function(hit)
		local player = partFunctionsMod.playerFromHit(hit)
		if player then
			local tagFolder = player:FindFirstChild("CoinTags")
			if not tagFolder then
				local tagFolder = Instance.new("Folder", player)
				tagFolder.Name = "CoinTags"
			end
			if not tagFolder:FindFirstChild(code) then
				dataMod.increment(player, "Coins", reward)
				
				local codeTag = Instance.new("BoolValue", tagFolder)
				codeTag.Name = code
				--to connect with effect in the client side
				effectsEvent:FireClient(player, part)
			end
		end
	end)
end

--for badge rewarded parts-----------------------------------------------------------------------------

local badgeService = game:GetService("BadgeService")


function partFunctionsMod.BadgeParts(part)
	local badgeId = part.BadgeId.Value
	
	part.Touched:Connect(function(hit)
		local player = partFunctionsMod.playerFromHit(hit)
		
		if player then
			local key = player.UserId
			local hasBadge = badgeService:UserHasBadgeAsync(key, badgeId)
			
			if not hasBadge then
				badgeService:AwardBadge(key, badgeId)
			end
			
		end		
	end)
end

--for parts that can be purchased----------------------------------------------------------------------

local marketService = game:GetService("MarketplaceService")

function partFunctionsMod.PurchaseParts(part)
	local promptId = part.PromptId.Value
	local isProduct = part.IsProduct.Value
	
	part.Touched:Connect(function(hit)
		local player = partFunctionsMod.playerFromHit(hit)
		
		if player then
			if isProduct then
				marketService:PromptProductPurchase(player,
					promptId)
			else
				marketService:PromptGamePassPurchase(player,
					promptId)
			end
		end
	end)
end

--for parts that correspond to ShopItems that will be in Backpack-------------------------------------

local items = {
	["Spring Potion"] = {
		Price = 100;
	};
}


function partFunctionsMod.ShopParts(part)
	local itemName = part.ItemName.Value
	local item = items[itemName]
	
	part.Touched:Connect(function(hit)
		local player = partFunctionsMod.playerFromHit(hit)
		if player and dataMod.get(player, "Coins") >= item.Price then
			dataMod.increment(player, "Coins", - item.Price)
			local shopFolder = replicatedStorage.ShopItems
			local tool = shopFolder:FindFirstChild(itemName):Clone()
			tool.Parent = player.Backpack
		end
	end)
end


local partGroup = {
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
	
}

--to connect functions on partFunctionsMod to Folder of parts inside Workspace-------------------------
for _, group in pairs(partGroup) do
	for _, part in pairs(group:GetChildren()) do
		repeat wait() until part
		if part:IsA("BasePart") then
			partFunctionsMod[group.Name](part)
		end
	end
end


return partFunctionsMod 