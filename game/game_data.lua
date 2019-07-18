-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.
local item_creator = require("items.item_creator")
local enemy_creator = require("enemies.enemy_creator")
local class_creator = require("player.class_creator")

local my_file_path = sys.get_save_file("rps_loot", "game_data")
print(my_file_path)


local M = sys.load(my_file_path) or {}

-- next(M) == nil
if true then -- While in development I'll just recreate each time
	print("Generator if statement start")

	M.items = item_creator.generate_game_items()

	M.enemies = enemy_creator.generate_game_enemies()
	for key, enemy in pairs(M.enemies) do
		enemy.shield = M.items.shield[enemy.shield]
		enemy.scroll = M.items.scroll[enemy.scroll]
		enemy.sword = M.items.sword[enemy.sword]
		enemy.special = M.items.special[enemy.special]
	end

	M.classes = class_creator.generate_game_classes()
	for key, class in pairs(M.classes) do
		class.shield = M.items.shield[class.shield] --creator just gives it the name, need to reference full item from items table
		class.scroll = M.items.scroll[class.scroll]
		class.sword = M.items.sword[class.sword]
		class.special = M.items.special[class.special]
		class.inventory.shield = class.shield --build out class inventory
		class.inventory.scroll = class.scroll
		class.inventory.sword = class.sword
		pprint(class)
	end

	M.player = {current_class = M.classes["rogue"], current_level = 1, special = {}}
	
	sys.save(my_file_path, M)
	
	print("Generator if statement end")
end

function update_player_level(trigger)
	if trigger == "next" then
		M.player.current_level = M.player.current_level + 1
	elseif trigger == "reset" then
		M.player.current_level = 1
	else
		print("Update Player level error")
	end
	save_game_data()
end


function save_game_data()
	sys.save(my_file_path, M)
end

function load_game_data()
	sys.load(my_file_path)
end

return M