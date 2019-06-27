-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.

player = {health = 3, shield = master_item_table[1], scroll = master_item_table[2],
sword = master_item_table[3], special = nil}

print("Player starter shield is " .. player.shield["name"])

function player:take_damage(dmg)
	self.health = self.health - dmg
	return self.health
end