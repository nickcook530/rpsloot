-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.

local enemy_items = {shield=master_item_table[1], scroll=master_item_table[2], sword=master_item_table[3]}

local shield_range_upper = 50
local scroll_range_upper = 80
local sword_range_upper = 100
local special_range_upper = nil

function generate_move()
	local move_number = math.random(100)
	if move_number <= shield_range_upper then
		return "shield"
	elseif move_number > shield_range_upper and move_number <= scroll_range_upper then
		return "scroll"
	elseif move_number > scroll_range_upper and move_number <= sword_range_upper then
		return "sword"
	elseif move_number > sword_range_upper and move_number <= special_range_upper then
		return "special"
	end
end