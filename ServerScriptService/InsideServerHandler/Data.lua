local playerService = game:GetService("Players")
local dataService = game:GetService("DataStoreService")
local store = dataService:GetDataStore("From_Hell_Obby_0.2.5")
local PetDataStore = dataService:GetDataStore("PetDataStore_0.2.5")
local BackpackDataStore = dataService:GetDataStore("BackpackDataStore_0.2.5")
local sessionData = {} 



----------------------------------------------------------------
local dataMod = {}
local AUTOSAVE_INTERVAL = 30


function dataMod.recursiveCopy(dataTable) 
	local tableCopy = {}
	for index, value in pairs(dataTable) do
		if type(value) == "table" then
			value = dataMod.recursiveCopy(value)
		end
		tableCopy[index] = value
	end
	return tableCopy	
end


local defaultData = {
	Coins = 0;
	Stage = 1;
}


-----------------------------------Creating and loading session data

function dataMod.load(player)
	local key = player.UserId
	local data
	local success, err = pcall(function() 
		data = store:GetAsync(key)
	end)
	if not success then
		dataMod.load(player)
	end
	return data
end


function dataMod.setupData(player)
	local key = player.UserId
	local data = dataMod.load(player)
	sessionData[key] = dataMod.recursiveCopy(defaultData)
	if data then
		for index, value in pairs(data) do
			dataMod.set(player, index, value)
		end
		print(player.Name.. "'s data has been loaded")
	else
		print(player.Name.. "is a new player")
	end
end








playerService.PlayerAdded:Connect(function(player)
		
	print(player.Name.. " joined the game")
		
	local char = player.Character

	local leaderstats = Instance.new("Folder", player)
	leaderstats.Name = "leaderstats"

	local coins = Instance.new("IntValue", leaderstats)
	coins.Name = "Coins"
	coins.Value = defaultData.Coins

	local stage = Instance.new("IntValue", leaderstats)
	stage.Name = "Stage"
	stage.Value = defaultData.Stage
	
	local inventory = Instance.new("Folder", player)
	inventory.Name = "PetInventory"
	
	local equippedPet = Instance.new("StringValue", player)
	equippedPet.Name = "EquippedPet"
	
	local potionsInventory = Instance.new("Folder", player)
	potionsInventory.Name = "PotionsInventory"
	
	local carsInventory = Instance.new("Folder", player)
	carsInventory.Name = "CarsInventory"
	
	dataMod.setupData(player)	
	
-------------------------------------------------------	
	---------------------PETS-------------------------
-------------------------------------------------------
	
	local function equipPet(player, pet)
		local character = player.Character

		if pet ~= nil and character ~= nil then

			if character:FindFirstChild(player.Name.."'s Pet") then -- Destroy old pet
				character[player.Name.."'s Pet"]:Destroy() 
			end

			if character.HumanoidRootPart:FindFirstChild("attachmentCharacter") then -- Destroy the old character attachment (pet's attachemt get's destroyed with pet)
				character.HumanoidRootPart:FindFirstChild("attachmentCharacter"):Destroy()
			end

			pet.Name = player.Name.."'s Pet"

			pet:SetPrimaryPartCFrame(character.HumanoidRootPart.CFrame)

			local modelSize = pet.PrimaryPart.Size
			local attachmentCharacter = Instance.new("Attachment")
			attachmentCharacter.Name = "attachmentCharacter"
			attachmentCharacter.Visible = false
			attachmentCharacter.Parent = character.HumanoidRootPart
			attachmentCharacter.Position = Vector3.new(1,1,0) + modelSize	

			local attachmentPet = Instance.new("Attachment")
			attachmentPet.Visible = false
			attachmentPet.Parent = pet.PrimaryPart -- don't need to do positioning because just parenting it to the pet's primary part it will put it in the middle of the pet

			local alignPosition = Instance.new("AlignPosition") -- this will make the two attachments keep together
			alignPosition.MaxForce = 25000
			alignPosition.Attachment0 = attachmentPet
			alignPosition.Attachment1 = attachmentCharacter
			alignPosition.Responsiveness = 25
			alignPosition.Parent = pet

			local alignOrientation = Instance.new("AlignOrientation")
			alignOrientation.MaxTorque = 25000
			alignOrientation.Attachment0 = attachmentPet
			alignOrientation.Attachment1 = attachmentCharacter
			alignOrientation.Responsiveness = 25
			alignOrientation.Parent = pet

			pet.Parent = character
		end

	end
	
	player.CharacterAdded:Connect(function(char) -- when character respawns reequip pet if character had a pet equipped
		if game.ReplicatedStorage:WaitForChild("Pets"):FindFirstChild(equippedPet.Value) then
			equipPet(player, game.ReplicatedStorage:WaitForChild("Pets"):FindFirstChild(equippedPet.Value):Clone())
		end
	end)
	
	equippedPet.Changed:Connect(function() -- when the value of equippedPet changes it recalls the equipPet function
		if equippedPet.Value ~= nil then
			if game.ReplicatedStorage:WaitForChild("Pets"):FindFirstChild(equippedPet.Value) then
				equipPet(player, game.ReplicatedStorage:WaitForChild("Pets"):FindFirstChild(equippedPet.Value):Clone())
			end
		end
	end)
	
	-- to get from dataStore the pet we got in our inventory when we got out of the game
	local petData = PetDataStore:GetAsync(player.UserId.."-pet")
	
	if petData then
		--We know that petData is a table containing the names of owned pets
		for _, petName in pairs(petData) do
			if game.ReplicatedStorage:WaitForChild("Pets"):FindFirstChild(petName) then
				local stringValue = Instance.new("StringValue")
				stringValue.Name = petName
				stringValue.Parent = player.PetInventory
			end
		end

		game.ReplicatedStorage.SendPetData:FireClient(player, petData)
		print("Pet Send Data Fired")
	else 
		print("No Pet Data")
	end

	-- to equip the pet we had equipped when we got out of the game

	local equippedPetData = PetDataStore:GetAsync(player.UserId.."-equippedPet")

	if equippedPetData then 
		equippedPet.Value = equippedPetData -- calls the Changed Event created for equippedPet and equips pet
		game.ReplicatedStorage.SetEquippedPetInInventory:FireClient(player, equippedPetData) -- to connect with remote event so client shows equipped pet in inventory as EQUIPPED
	end
end)

--------------- PET EQUIPPED
game.ReplicatedStorage.EquipPet.OnServerEvent:Connect(function(player, petName)
	local pet = game.ReplicatedStorage.Pets:FindFirstChild(petName)

	if pet and player.PetInventory:FindFirstChild(petName) then
		player.EquippedPet.Value = petName
	end
end)

-----------------PET UNEQUIPPED
game.ReplicatedStorage.UnequipPet.OnServerEvent:Connect(function(player)
	player.EquippedPet.Value = ""

	if player.Character:FinfFirstChild(player.Name.."'s Pet") then -- Destroy unequipped pet
		player.Character[player.Name.."'s Pet"]:Destroy() -- between square brackets because we already know it's there
	end

	if player.Character.HumanoidRootPart:FindFirstChild("attachmentCharacter") then -- destroy unused character attachment
		player.Character.HumanoidRootPart:FindFirstChild("attachmentCharacter"):Destroy()
	end

end)


------------------------SAVE PET DATA TO PETDATASTORE-------------
function dataMod.savePetData(player)
	if player:FindFirstChild("PetInventory") then
		local inventory = {}

		for i, v in pairs(player.PetInventory:GetChildren()) do
			table.insert(inventory, v.Name)	
		end

		local success, errorMessage = pcall(function()
			PetDataStore:SetAsync(player.UserId.."-pet", inventory)	
		end)

		if success then
			print("Pet Data Saved")
		else
			print("Pet Data Saving ERROR: "..errorMessage)
		end
	end

	if player:FindFirstChild("EquippedPet") then
		if player.EquippedPet.Value ~= nil then
			local success, errorMessage = pcall(function()
				PetDataStore:SetAsync(player.UserId.."-equippedPet", player.EquippedPet.Value)
			end)
		end
	end

end

-------------------------------------------------------------------------------------
--END OF PETS
-------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------
--BACKPACK (POTIONS)
-------------------------------------------------------------------------------------

--SAVE TO DATASTORE BACKPACK POTIONS

function dataMod.saveBackpackData(player)
	
	if player then
		print("Saving Backpack Data")
		local backpack = {}

		for i, v in pairs(player:FindFirstChildOfClass("Backpack"):GetChildren()) do
			table.insert(backpack, v.Name)	
		end

		local success, errorMessage = pcall(function()
			BackpackDataStore:SetAsync(player.UserId.."-backpack", backpack)	
		end)

		if success then
			print("Backpack Data Saved")
		else
			print("Backpack Data Saving ERROR: "..errorMessage)
		end
	end
end

-- to get from dataStore the POTIONS we got in our BACKPACK when we got out of the game

playerService.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(char)
		local backpackData = BackpackDataStore:GetAsync(player.UserId.."-backpack")

		--TO SAVE POTIONS WHEN CHARACTER DIES
		char:WaitForChild("Humanoid").Died:Connect(function()
			dataMod.saveBackpackData(player)
		end)

		if backpackData then
			--We know that backpackData is a table containing the names of owned potions
			--to equip owned potions in backpack

			for _, potionName in pairs(backpackData) do
				if game.ServerStorage:WaitForChild("Tools"):FindFirstChild(potionName) then
					local potion = game.ServerStorage.Tools:FindFirstChild(potionName):Clone()
					potion.Parent = player:FindFirstChildOfClass("Backpack")
					--player:WaitForChild("PotionsInventory"):FindFirstChild(potionName).PotionEquipped.Value = true
				end
			end
		else 
			print("No Backpack Data")
		end
	end)

end)


-----------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------

	
--------------------------------Manipulating session data


function dataMod.set(player, stat, value)
	local key = player.UserId
	sessionData[key][stat] = value
	player.leaderstats[stat].Value = value
end


function dataMod.increment(player, stat, value) 
	local key = player.UserId
	sessionData[key][stat] = dataMod.get(player, stat) + value
	player.leaderstats[stat].Value = dataMod.get(player,stat)
end


function dataMod.get(player, stat)
	local key = player.UserId
	return sessionData[key][stat]
end

--Saving player data
function dataMod.save(player)
	local key = player.UserId
	local data = dataMod.recursiveCopy(sessionData[key])
	local success, err = pcall(function()
		store:SetAsync(key, data)
	end)
	if success then
		print(player.Name.. "'s data has been saved!")
	else
		dataMod.save(player)
	end
end

--Removing the player's data table from sessionData when a player leaves the game
function dataMod.removeSessionData(player)
	local key = player.UserId
	sessionData[key] = nil
end
	
	
	


playerService.PlayerRemoving:Connect(function(player) -- TO SAVE DATA WHEN PLAYER LEAVES
	dataMod.save(player)
	dataMod.savePetData(player)
	dataMod.saveBackpackData(player)
	dataMod.removeSessionData(player)
end)



local function autoSave()
	while wait(AUTOSAVE_INTERVAL) do
		print("Auto-saving data for all players")
		for key, dataTable in pairs(sessionData) do
			local player = playerService:GetPlayerByUserId(key)
			dataMod.save(player)
		end
	end
end

--Initialize autosave loop
spawn(autoSave) 


game:BindToClose(function() -- TO SAVE WHEN SERVER SHUTS DOWN
	for _, player in pairs(playerService:GetPlayers()) do
		dataMod.save(player)
		dataMod.savePetData(player)
		dataMod.saveBackpackData(player)
		player:Kick("Shutting down game. All data saved")
	end
end)

return dataMod