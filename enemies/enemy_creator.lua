-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.

local functions = {}

local game_enemies = {}

local enemy = {}
enemy.__index = enemy

function enemy.new(name, health, shield, shield_range_upper, scroll, scroll_range_upper, sword, sword_range_upper, special, special_range_upper)
	return setmetatable({name = name, health = health, shield = shield, shield_range_upper = shield_range_upper,
		scroll = scroll, scroll_range_upper = scroll_range_upper, sword = sword, sword_range_upper = sword_range_upper, 
		special = special, special_range_upper = special_range_upper}, enemy)
end

local function create_new_enemy(name, health, shield, shield_range_upper, scroll, scroll_range_upper, sword, sword_range_upper, special, special_range_upper)
	local enemy_table = enemy.new(name, health, shield, shield_range_upper, scroll, scroll_range_upper, sword, sword_range_upper, special, special_range_upper)
	table.insert(game_enemies, enemy_table)

	print(enemy_table["name"] .. " CREATED")
end

function functions.generate_game_enemies()
	create_new_enemy("Basic Enemy", 3, "starter_shield", 50, "starter_scroll", 80, "starter_sword", 100, "test_special", 5)
	return game_enemies
end

return functions


