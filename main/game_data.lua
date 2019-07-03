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

if next(M) == nil then
	print("Generator if statement start")
	M.items = item_creator.generate_game_items()

	M.enemies = enemy_creator.generate_game_enemies()
	
	M.player = player_creator.generate_player()
	M.player.shield = M.items[1]
	M.player.scroll = M.items[2]
	M.player.sword = M.items[3]

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