-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.

local gf = {}

function gf.generate_deck(character)
	local deck = {}
	for i=1, character.shield_count do
		table.insert(deck, character.shield)
	end
	for i=1, character.scroll_count do
		table.insert(deck, character.scroll)
	end
	for i=1, character.sword_count do
		table.insert(deck, character.sword)
	end
	for i=1, character.special_count do
		table.insert(deck, character.special)
	end
	return deck
end

function gf.draw_card(deck)
	local number = math.random(#deck)
	local card = deck[number]
	table.remove(deck, number)
	return {deck=deck, card=card}
end

function gf.make_hand_node(player_card, position)
	local card_tree = gui.clone_tree(gui.get_node("player_card"))
	gui.set_text(card_tree[hash("card_text")], player_card.name)
	gui.set_texture(card_tree[hash("card_image")], "player_items")
	gui.play_flipbook(card_tree[hash("card_image")], player_card.type)
	card_tree["card_details"] = player_card --passed to game gui for logic
	gui.set_position(card_tree[hash("player_card")], position)
	
	return card_tree
end

function gf.initial_player_hand(deck, move_positions)
	local return_table = {}
	for i=1, 3 do
		local deck_and_card = gf.draw_card(deck)
		local player_card = deck_and_card.card
		
		local card_tree = gf.make_hand_node(player_card, move_positions[i])

		table.insert(return_table, card_tree)
	end
	return return_table
end

function gf.generate_move_option(character)
	local move_number = math.random(100)
	local special_number = math.random(100)
	local move = nil

	if move_number <= character.shield_range_upper then
		move = "shield"
	elseif move_number > character.shield_range_upper and move_number <= character.scroll_range_upper then
		move = "scroll"
	elseif move_number > character.scroll_range_upper and move_number <= character.sword_range_upper then
		move = "sword"
	end
	if special_number <= character.special_range_upper then
		move = "special"
	end
	return move
end

function gf.generate_enemy_move_nodes(enemy, move_positions)
	local return_table = {}
	for i=1, 3 do
		local enemy_move = gf.generate_move_option(enemy)
		local move_tree = gui.clone_tree(gui.get_node("enemy_move"))
		gui.set_text(move_tree[hash("move_text")], enemy[enemy_move]["name"])
		gui.set_texture(move_tree[hash("move_image")], "enemy_items")
		gui.play_flipbook(move_tree[hash("move_image")], enemy_move)
		gui.set_position(move_tree[hash("enemy_move")], move_positions[i])
		move_tree["move_type"] = enemy_move
		table.insert(return_table, move_tree)
	end
	return return_table
end

function gf.select_move(move_options)
	local move_number = math.random(#move_options)
	return move_options[move_number]
end

function gf.health_change(character, heal, dmg)
	character.health = character.health + heal
	character.health = character.health - dmg
	return character.health
end

function gf.determine_outcome(player_card_type, enemy_card_type)
	if player_card_type == "shield" then
		if enemy_card_type == "shield" then
			return {player_result = "tie", enemy_result = "tie"}
		elseif enemy_card_type == "scroll" then
			return {player_result = "loss", enemy_result = "win"}
		elseif enemy_card_type == "sword" then
			return {player_result = "win", enemy_result = "loss"}
		elseif enemy_card_type == "special" then
			return {player_result = "loss", enemy_result = "win"}
		else
			print("NO RESULT FOUND FOR "..player_card_type)
		end

	elseif player_card_type == "scroll" then
		if enemy_card_type == "shield" then
			return {player_result = "win", enemy_result = "loss"}
		elseif enemy_card_type == "scroll" then
			return {player_result = "tie", enemy_result = "tie"}
		elseif enemy_card_type == "sword" then
			return {player_result = "loss", enemy_result = "win"}
		elseif enemy_card_type == "special" then
			return {player_result = "loss", enemy_result = "win"}
		else
			print("NO RESULT FOUND FOR "..player_card_type)
		end 

	elseif player_card_type == "sword" then
		if enemy_card_type == "shield" then
			return {player_result = "loss", enemy_result = "win"}
		elseif enemy_card_type == "scroll" then
			return {player_result = "win", enemy_result = "loss"}
		elseif enemy_card_type == "sword" then
			return {player_result = "tie", enemy_result = "tie"}
		elseif enemy_card_type == "special" then
			return {player_result = "loss", enemy_result = "win"}
		else
			print("NO RESULT FOUND FOR "..player_card_type)
		end 

	elseif player_card_type == "special" then
		if enemy_card_type == "shield" then
			return {player_result = "win", enemy_result = "loss"}
		elseif enemy_card_type == "scroll" then
			return {player_result = "win", enemy_result = "loss"}
		elseif enemy_card_type == "sword" then
			return {player_result = "win", enemy_result = "loss"}
		elseif enemy_card_type == "special" then
			return {player_result = "tie", enemy_result = "tie"} --might be easiest to just handle this as a win?
		else
			print("NO RESULT FOUND FOR "..player_card_type)
		end 
	else
		print("ERROR ON OUTCOME")
	end
end


--given items correctly distribute effects to player or enemy
function gf.get_effects(caller, player_item_effect, enemy_item_effect)
	local effects = {}
	if caller == "player" then
		if player_item_effect.target == "self" then
			table.insert(effects, player_item_effect)
		elseif enemy_item_effect.target == "opponent" then
			table.insert(effects, enemy_item_effect)
		else
			print("NO EFFECTS for player")
		end
	elseif caller == "enemy" then
		if player_item_effect.target == "opponent" then
			table.insert(effects, player_item_effect)
		elseif enemy_item_effect.target == "self" then
			table.insert(effects, enemy_item_effect)
		else
			print("NO EFFECTS for enemy")
		end
	end
	return effects
end

--trigger effects to take action
function gf.trigger_effects(health, effect_table)
	local initial_health = health
	for k, effect in pairs(effect_table) do
		health = health + effect.hp_change
		effect.duration = effect.duration - 1
		if effect.duration == 0 then
			table.remove(effect_table, k)
		end
	end
	local hp_change = health - initial_health
	return {health = health, hp_change = hp_change, effect_table = effect_table}
end

function gf.add_new_effects(new_effects, effect_table)
	for k, new_effect in pairs(new_effects) do
		print("new effect: ")
		pprint(new_effect)
		for i, current_effect in pairs(effect_table) do
			print("current effect: ")
			pprint(current_effect)
			if new_effect.name == current_effect.name then
				table.remove(effect_table, i)
				--current_effect.duration = new_effect.duration
			end
		end
		table.insert(effect_table, new_effect)
	end
	return effect_table
end

function gf.clear_previous_results(self)
	if self.results_showing then
		print("CLEAR RUNNING")
		gui.set_color(gui.get_node("outcome"), vmath.vector4(0, 0, 0, 0))
		msg.post("/enemy/enemy#enemy", "delete_previous_node")
		msg.post("/player/player#player", "delete_previous_node")
		self.results_showing = false
	else
		print("CLEARING RESULTS SKIPPED")
	end
end

return gf