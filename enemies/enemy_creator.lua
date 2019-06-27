-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.

master_enemy_table = {}
max_key_master_enemy_table = 1

enemy = {}
enemy.__index = enemy

function enemy.new(name, health, shield, shield_range_upper, scroll, scroll_range_upper, sword, sword_range_upper, special, special_range_upper)
	return setmetatable({name = name, health = health, shield = shield, shield_range_upper = shield_range_upper,
		scroll = scroll, scroll_range_upper = scroll_range_upper, sword = sword, sword_range_upper = sword_range_upper, 
		special = special, special_range_upper = special_range_upper}, enemy)
end

function enemy:generate_move()
	local move_number = math.random(100)
	if move_number <= self.shield_range_upper then
		return "shield"
	elseif move_number > self.shield_range_upper and move_number <= self.scroll_range_upper then
		return "scroll"
	elseif move_number > self.scroll_range_upper and move_number <= self.sword_range_upper then
		return "sword"
	elseif move_number > self.sword_range_upper and move_number <= self.special_range_upper then
		return "special"
	end
end

function create_new_enemy(name, health, shield, shield_range_upper, scroll, scroll_range_upper, sword, sword_range_upper, special, special_range_upper)
	local enemy_table = enemy.new(name, health, shield, shield_range_upper, scroll, scroll_range_upper, sword, sword_range_upper, special, special_range_upper)
	master_enemy_table[max_key_master_enemy_table] = enemy_table
	max_key_master_enemy_table = max_key_master_enemy_table + 1
	print(enemy_table["name"] .. " CREATED")
end

create_new_enemy("Basic Enemy", 3, master_item_table[1], 50, master_item_table[2], 80, master_item_table[3], 100, nil, nil)


