-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.

local functions = {}

local player = {health = 3, shield_range_upper = 3, scroll_range_upper = 6, sword_range_upper = 10, shield = nil, scroll = nil,
sword = nil, special = nil}

function functions.generate_player()
	return player
end

return functions

