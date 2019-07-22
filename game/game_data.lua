-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.
local card_creator = require("cards.card_creator")
local enemy_creator = require("enemies.enemy_creator")
local class_creator = require("player.class_creator")

local my_file_path = sys.get_save_file("rps_loot", "game_data")
print(my_file_path)


local M = sys.load(my_file_path) or {}

-- next(M) == nil
if true then -- While in development I'll just recreate each time, in production us check above to see if save exists
	print("Generator if statement start")

	M.cards = card_creator.generate_game_cards()

	M.enemies = enemy_creator.generate_game_enemies()
	for key, enemy in pairs(M.enemies) do
		enemy.shield = M.cards.shield[enemy.shield]
		enemy.scroll = M.cards.scroll[enemy.scroll]
		enemy.sword = M.cards.sword[enemy.sword]
		enemy.special = M.cards.special[enemy.special]
	end

	M.classes = class_creator.generate_game_classes()
	for key, class in pairs(M.classes) do
		class.shield = M.cards.shield[class.shield] --creator just gives it the name, need to reference full card from card table
		class.scroll = M.cards.scroll[class.scroll]
		class.sword = M.cards.sword[class.sword]
		class.special = M.cards.special[class.special]
		class.collection.shield = class.shield --build out class basic collection
		class.collection.scroll = class.scroll
		class.collection.sword = class.sword
		pprint(class)
	end

	M.player = {current_class = M.classes["rogue"], current_level = 1}
	
	sys.save(my_file_path, M)
	
	print("Generator if statement end")
end

--advance player one level on win or reset on loss
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