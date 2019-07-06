-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.
local item_creator = require("items.item_creator")
local enemy_creator = require("enemies.enemy_creator")
local player_creator = require("player.player_creator")

local my_file_path = sys.get_save_file("rps_loot", "game_data")
print(my_file_path)


local M = sys.load(my_file_path) or {}

-- next(M) == nil
if true then -- While in development I'll just recreate each time
	print("Generator if statement start")
	M.items = item_creator.generate_game_items()

	M.enemies = enemy_creator.generate_game_enemies()
	pprint(M.enemies)
	for key, enemy in pairs(M.enemies) do
		enemy.shield = M.items.shield[enemy.shield]
		enemy.scroll = M.items.scroll[enemy.scroll]
		enemy.sword = M.items.sword[enemy.sword]
		enemy.special = M.items.special[enemy.special]
	end
	
	M.player = player_creator.generate_player()
	M.player.shield = M.items.shield["starter_shield"]
	M.player.scroll = M.items.scroll["starter_scroll"]
	M.player.sword = M.items.sword["starter_sword"]
	M.player.special = M.items.special["test_special"]
	
	sys.save(my_file_path, M)
	
	print("Generator if statement end")
end

function save_game_data()
	sys.save(my_file_path, M)
end

function load_game_data()
	sys.load(my_file_path)
end

return M