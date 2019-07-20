-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.

local functions = {}

local game_items = {["shield"]={}, ["scroll"]={}, ["sword"]={}, ["special"]={}}

--[[
local item = {}
item.__index = item

function item.new(name, type, level, win_dmg, win_heal, win_effect, tie_dmg, tie_heal, tie_effect, loss_dmg, loss_heal, loss_effect)
	return setmetatable({name = name or "ERROR", type = type or "ERROR", level = level or "ERROR", win = { dmg = win_dmg or 0, heal = win_heal or 0,
	effect = win_effect or {}}, tie = { dmg = tie_dmg or 0, heal = tie_heal or 0, effect = tie_effect or {}},
	loss = { dmg = loss_dmg or 0, heal = loss_heal or 0, effect = loss_effect or {}} }, item)
end

local function create_new_item(name, type, level, win_dmg, win_heal, win_effect, tie_dmg, tie_heal, tie_effect, loss_dmg, loss_heal, loss_effect)
	local item_table = item.new(name, type, level, win_dmg, win_heal, win_effect, tie_dmg, tie_heal, tie_effect, loss_dmg, loss_heal, loss_effect)
	table.insert(game_items[type], item_table)

	print(item_table["name"] .. " CREATED")
end
--]]


local function create_new_item(table_key, name, type, level, win_dmg, win_heal, win_effect, tie_dmg, tie_heal, tie_effect, loss_dmg, loss_heal, loss_effect)
	game_items[type][table_key] = {name = name or "ERROR", type = type or "ERROR", level = level or "ERROR", win = { dmg = win_dmg or 0, heal = win_heal or 0,
	effect = win_effect or {}}, tie = { dmg = tie_dmg or 0, heal = tie_heal or 0, effect = tie_effect or {}},
	loss = { dmg = loss_dmg or 0, heal = loss_heal or 0, effect = loss_effect or {}} }

	print(name .. " CREATED")
end

function functions.generate_game_items()
	create_new_item("basic_shield_1", "Basic Shield", "shield", 1, 1, 0, nil, 0, 0, nil, 0, 0, nil)
	create_new_item("basic_scroll_1", "Basic Scroll", "scroll", 1, 1, 0, nil, 0, 0, nil, 0, 0, nil)
	create_new_item("basic_sword_1", "Basic Sword", "sword", 1, 1, 0, nil, 0, 0, nil, 0, 0, nil)
	create_new_item("test_special","Test Special", "special", 1, 1, 1, nil, 1, 1, nil, 1, 1, nil)
	create_new_item("fire_scroll_1", "Fire Scroll", "scroll", 1, 0, 0, {target = "opponent", name = "burning", hp_change = "-1", duration = 1}, 0, 0, nil, 0, 0, nil)

	return game_items
end

return functions

