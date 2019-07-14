-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.

local functions = {}

local game_classes = {}

local function create_new_class(table_key, name, health, shield_range_upper, scroll_range_upper, special, special_range_upper, unlocked)
	game_classes[table_key] = {name = name, health = health, shield = "starter_shield", shield_range_upper = shield_range_upper,
	scroll = "starter_scroll", scroll_range_upper = scroll_range_upper, sword = "starter_sword", sword_range_upper = 100, 
	special = special, special_range_upper = special_range_upper, unlocked = unlocked, completed = false}

	pprint(name .. " class CREATED")
end

function functions.generate_game_classes()
	create_new_class("rogue", "Rogue", 1, 20, 50, "test_special", 10, true)
	
	return game_classes
end

return functions

