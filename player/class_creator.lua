-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.

local functions = {}

local game_classes = {}

local function create_new_class(table_key, name, health, shield_range_upper, scroll_range_upper, special, special_range_upper, unlocked)
	game_classes[table_key] = {name = name, health = health, shield = "basic_shield_1", shield_range_upper = shield_range_upper,
	scroll = "fire_scroll_1", scroll_range_upper = scroll_range_upper, sword = "basic_sword_1", sword_range_upper = 100, 
	special = special, special_range_upper = special_range_upper, unlocked = unlocked, completed = false, inventory = {["shield"]={}, ["scroll"]={}, ["sword"]={}} }

	pprint(name .. " class CREATED")
end

function functions.generate_game_classes()
	create_new_class("rogue", "Rogue", 100, 70, 0, "test_special", 10, true)
	
	return game_classes
end

return functions

