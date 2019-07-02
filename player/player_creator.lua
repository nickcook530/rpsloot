-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.

player = {health = 3, shield_range_upper = 3, scroll_range_upper = 6, sword_range_upper = 10, shield = master_item_table[1], scroll = master_item_table[2],
sword = master_item_table[3], special = nil}

print("Player starter shield is " .. player.shield["name"])

function player:generate_move_option()
	local move_number = math.random(10)
	print("player move number: " .. move_number)
	if move_number <= self.shield_range_upper then
		return "shield"
	elseif move_number > self.shield_range_upper and move_number <= self.scroll_range_upper then
		return "scroll"
	elseif move_number > self.scroll_range_upper and move_number <= self.sword_range_upper then
		return "sword"
	end
end

function player:take_damage(dmg)
	self.health = self.health - dmg
	return self.health
end