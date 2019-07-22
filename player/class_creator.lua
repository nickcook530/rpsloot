-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.

local functions = {}

local game_classes = {}

local function create_new_class(table_key, name, health, shield_count, scroll_count, sword_count, special, unlocked)
	game_classes[table_key] = {name = name, health = health, shield = "basic_shield_1", shield_count = shield_count,
	scroll = "fire_scroll_1", scroll_count = scroll_count, sword = "basic_sword_1", sword_count = sword_count, 
	special = special, special_count = 1, unlocked = unlocked, completed = false, collection = {["shield"]={}, ["scroll"]={}, ["sword"]={}} }

	pprint(name .. " class CREATED")
end

function functions.generate_game_classes()
	--create_new_class("rogue", "Rogue", 100, 70, 0, "test_special", 10, true)
	create_new_class("rogue", "Rogue", 10, 2, 3, 4, "test_special", true)
	return game_classes
end

return functions

