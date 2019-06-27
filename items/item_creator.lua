-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.


-- Should eventually find a way to only generate this once then save it
master_item_table = {}

local function get_max_key(t)
	local tkeys = {}
	for k in pairs(t) do
		print(k)
		table.insert(tkeys, k)
	end
	table.sort(tkeys)
	return tkeys[#tkeys]
end

max_key_master_item_table = get_max_key(master_item_table) or 1
--^Possibly unnecessary if only input is during creation

item = {}
item.__index = item

function item.new(name, type, level, win_dmg, win_heal, win_effect, tie_dmg, tie_heal, tie_effect, loss_dmg, loss_heal, loss_effect)
	return setmetatable({name = name or "ERROR", type = type or "ERROR", level = level or "ERROR", on_win = { dmg = win_dmg or 0, heal = win_heal or 0,
	effect = win_effect or {}}, on_tie = { dmg = tie_dmg or 0, heal = tie_heal or 0, effect = tie_effect or {}},
	on_loss = { dmg = loss_dmg or 0, heal = loss_heal or 0, effect = loss_effect or {}} }, item)
end

function create_new_item(name, type, level, win_dmg, win_heal, win_effect, tie_dmg, tie_heal, tie_effect, loss_dmg, loss_heal, loss_effect)
	local item_table = item.new(name, type, level, win_dmg, win_heal, win_effect, tie_dmg, tie_heal, tie_effect, loss_dmg, loss_heal, loss_effect)
	master_item_table[max_key_master_item_table] = item_table
	max_key_master_item_table = max_key_master_item_table + 1
	print(item_table["name"] .. " CREATED")
end

create_new_item("Starter Shield", shield, 1, 1, 0, nil, 0, 0, nil, 0, 0, nil)
create_new_item("Starter Scroll", sword, 1, 1, 0, nil, 0, 0, nil, 0, 0, nil)
create_new_item("Starter Sword", sword, 1, 1, 0, nil, 0, 0, nil, 0, 0, nil)

--print(master_item_table[1]["name"])
--print(master_item_table[2]["name"])
--print(master_item_table[3]["name"])

