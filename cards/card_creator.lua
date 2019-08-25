-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.

local functions = {}

local game_cards = {["shield"]={}, ["scroll"]={}, ["sword"]={}, ["special"]={}}

local function create_new_card(table_key, name, type, level, win_dmg, win_heal, win_effect, tie_dmg, tie_heal, tie_effect, loss_dmg, loss_heal, loss_effect)
	game_cards[type][table_key] = {name = name or "ERROR", type = type or "ERROR", level = level or "ERROR", win = { dmg = win_dmg or 0, heal = win_heal or 0,
	effect = win_effect or {}}, tie = { dmg = tie_dmg or 0, heal = tie_heal or 0, effect = tie_effect or {}},
	loss = { dmg = loss_dmg or 0, heal = loss_heal or 0, effect = loss_effect or {}} }

	print(name .. " CREATED")
end

function functions.generate_game_cards()
	--***********        SHIELDS         *************
	--Basic Shield
	create_new_card("basic_shield_1", "Basic Shield", "shield", 1, 1, 0, nil, 0, 0, nil, 0, 0, nil)
	create_new_card("basic_shield_2", "Basic Shield", "shield", 2, 2, 0, nil, 0, 0, nil, 0, 0, nil)
	create_new_card("basic_shield_3", "Basic Shield", "shield", 3, 3, 0, nil, 0, 0, nil, 0, 0, nil)
	--Reinforced Shield
	create_new_card("reinforced_shield_1", "Reinforced Shield", "shield", 1, 1, 1, nil, 0, 0, nil, 0, 0, nil)
	create_new_card("reinforced_shield_2", "Reinforced Shield", "shield", 2, 1, 2, nil, 0, 0, nil, 0, 0, nil)
	create_new_card("reinforced_shield_3", "Reinforced Shield", "shield", 3, 1, 3, nil, 0, 0, nil, 0, 0, nil)
	--Anti-magic Shield
	create_new_card("anti-magic_shield_1", "Anti-magic Shield", "shield", 1, 1, 1, nil, 0, 0, nil, 0, 1, nil)
	create_new_card("anti-magic_shield_2", "Anti-magic Shield", "shield", 2, 2, 1, nil, 0, 0, nil, 0, 1, nil)
	create_new_card("anti-magic_shield_3", "Anti-magic Shield", "shield", 3, 3, 1, nil, 0, 0, nil, 0, 1, nil)
	--Tower Shield
	create_new_card("tower_shield_1", "Tower Shield", "shield", 1, 0, 2, nil, 0, 0, nil, 0, 0, nil)
	create_new_card("tower_shield_2", "Tower Shield", "shield", 2, 0, 3, nil, 0, 0, nil, 0, 0, nil)
	create_new_card("tower_shield_3", "Tower Shield", "shield", 3, 0, 4, nil, 0, 0, nil, 0, 0, nil)
	--Spiked Shield
	create_new_card("spiked_shield_1", "Spiked Shield", "shield", 1, 0, 1, {target = "opponent", name = "bleed", hp_change = "-2", duration = 2}, 0, 0, nil, 0, 0, nil)
	create_new_card("spiked_shield_2", "Spiked Shield", "shield", 2, 0, 1, {target = "opponent", name = "bleed", hp_change = "-2", duration = 2}, 0, 0, nil, 0, 0, nil)
	create_new_card("spiked_shield_3", "Spiked Shield", "shield", 3, 0, 1, {target = "opponent", name = "bleed", hp_change = "-2", duration = 2}, 0, 0, nil, 0, 0, nil)
	--Vitality Shield
	create_new_card("vitality_shield_1", "Vitality Shield", "shield", 1, 0, 1, {target = "self", name = "heal", hp_change = "1", duration = 2}, 0, 0, {target = "self", name = "heal", hp_change = "1", duration = 2}, 0, 0, nil)
	create_new_card("vitality_shield_2", "Vitality Shield", "shield", 2, 0, 1, {target = "self", name = "heal", hp_change = "2", duration = 2}, 0, 0, {target = "self", name = "heal", hp_change = "1", duration = 2}, 0, 0, nil)
	create_new_card("vitality_shield_3", "Vitality Shield", "shield", 3, 0, 1, {target = "self", name = "heal", hp_change = "3", duration = 2}, 0, 0, {target = "self", name = "heal", hp_change = "1", duration = 2}, 0, 0, nil)
	
	--***********        SCROLLS         *************
	--Basic Scroll
	create_new_card("basic_scroll_1", "Basic Scroll", "scroll", 1, 1, 0, nil, 0, 0, nil, 0, 0, nil)


	--Fire Scroll
	create_new_card("fire_scroll_1", "Fire Scroll", "scroll", 1, 0, 0, {target = "opponent", name = "burn", hp_change = "-1", duration = 3}, 0, 0, nil, 0, 0, nil)
	
	--***********        SWORDS         *************
	--Basic Sword
	create_new_card("basic_sword_1", "Basic Sword", "sword", 1, 1, 0, nil, 0, 0, nil, 0, 0, nil)

	--***********        SPECIALS         *************
	--Test Special
	create_new_card("test_special","Test Special", "special", 1, 1, 1, nil, 1, 1, nil, 1, 1, nil)

	return game_cards
end

return functions

