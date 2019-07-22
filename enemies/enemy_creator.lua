-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.

local functions = {}

local game_enemies = {}

--Could probably remove OOP design considering limitations of sys.save (cant' save functions)
local enemy = {}
enemy.__index = enemy

function enemy.new(name, health, shield, shield_count, scroll, scroll_count, sword, sword_count, special, special_count)
	return setmetatable({name = name, health = health, shield = shield, shield_count = shield_count,
		scroll = scroll, scroll_count = scroll_count, sword = sword, sword_count = sword_count, 
		special = special, special_count = special_count}, enemy)
end

local function create_new_enemy(name, health, shield, shield_count, scroll, scroll_count, sword, sword_count, special, special_count)
	local enemy_table = enemy.new(name, health, shield, shield_count, scroll, scroll_count, sword, sword_count, special, special_count)
	table.insert(game_enemies, enemy_table)

	print(enemy_table["name"] .. " CREATED")
end

function functions.generate_game_enemies()
	create_new_enemy("Enemy Level 1", 3, "basic_shield_1", 2, "fire_scroll_1", 6, "basic_sword_1", 1, "test_special", 1)
	create_new_enemy("Enemy Level 2", 30, "basic_shield_1", 2, "fire_scroll_1", 6, "basic_sword_1", 1, "test_special", 1)
	return game_enemies
end

return functions


