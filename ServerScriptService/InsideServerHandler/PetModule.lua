local petModule = {}

petModule.pets = {
	
	["Legendary"] = {
		game.ReplicatedStorage:WaitForChild("Pets"):WaitForChild("Eagle");
		game.ReplicatedStorage:WaitForChild("Pets"):WaitForChild("Dinosaur");
	};
	
	["Rare"] = {
		game.ReplicatedStorage:WaitForChild("Pets"):WaitForChild("Turtle");
		game.ReplicatedStorage:WaitForChild("Pets"):WaitForChild("Wolf");
	};
	
	["Uncommon"] = {
		game.ReplicatedStorage:WaitForChild("Pets"):WaitForChild("Rabbit");
	};
	
	["Common"] = {
		game.ReplicatedStorage:WaitForChild("Pets"):WaitForChild("Dog");
		game.ReplicatedStorage:WaitForChild("Pets"):WaitForChild("Cat");
	};
}

--Weighted selection -- 100 total weight

petModule.rarities = {
	
	["Legendary"] = 5;
		
	["Rare"] = 15;
		
	["Uncommon"] = 30;
		
	["Common"] = 50;
	
}

petModule.chooseRandomPet = function()
	
	local randomNumber = math.random(1, 100)
	
	local counter = 0
	
	for rarity, weight in pairs(petModule.rarities) do
		counter = counter + weight
		if randomNumber <= counter then
			
			local rarityTable = petModule.pets[rarity]
			local chosenPet = rarityTable[math.random(1, #rarityTable)]
			
			return chosenPet
		end
	end
	
end

return petModule