-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.

local gf = {}

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

function gf.generate_player_move_nodes(player, move_positions)
	local return_table = {}
	for i=1, 3 do
		local player_move = gf.generate_move_option(player)
		local move_tree = gui.clone_tree(gui.get_node("player_move"))

		gui.set_text(move_tree[hash("move_text")], player[player_move]["name"])
		gui.set_texture(move_tree[hash("move_image")], "player_items")
		gui.play_flipbook(move_tree[hash("move_image")], player_move)
		gui.set_position(move_tree[hash("player_move")], move_positions[i])
		move_tree["move_type"] = player_move

		table.insert(return_table, move_tree)
	end
	return return_table
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

function gf.determine_outcome(player_move, enemy_move)
	if player_move == "shield" then
		if enemy_move == "shield" then
			return {player_result = "tie", enemy_result = "tie"}
		elseif enemy_move == "scroll" then
			return {player_result = "loss", enemy_result = "win"}
		elseif enemy_move == "sword" then
			return {player_result = "win", enemy_result = "loss"}
		elseif enemy_move == "special" then
			return {player_result = "loss", enemy_result = "win"}
		else
			print("NO RESULT FOUND FOR "..player_move)
		end

	elseif player_move == "scroll" then
		if enemy_move == "shield" then
			return {player_result = "win", enemy_result = "loss"}
		elseif enemy_move == "scroll" then
			return {player_result = "tie", enemy_result = "tie"}
		elseif enemy_move == "sword" then
			return {player_result = "loss", enemy_result = "win"}
		elseif enemy_move == "special" then
			return {player_result = "loss", enemy_result = "win"}
		else
			print("NO RESULT FOUND FOR "..player_move)
		end 

	elseif player_move == "sword" then
		if enemy_move == "shield" then
			return {player_result = "loss", enemy_result = "win"}
		elseif enemy_move == "scroll" then
			return {player_result = "win", enemy_result = "loss"}
		elseif enemy_move == "sword" then
			return {player_result = "tie", enemy_result = "tie"}
		elseif enemy_move == "special" then
			return {player_result = "loss", enemy_result = "win"}
		else
			print("NO RESULT FOUND FOR "..player_move)
		end 

	elseif player_move == "special" then
		if enemy_move == "shield" then
			return {player_result = "win", enemy_result = "loss"}
		elseif enemy_move == "scroll" then
			return {player_result = "win", enemy_result = "loss"}
		elseif enemy_move == "sword" then
			return {player_result = "win", enemy_result = "loss"}
		elseif enemy_move == "special" then
			return {player_result = "tie", enemy_result = "tie"} --might be easiest to just handle this as a win?
		else
			print("NO RESULT FOUND FOR "..player_move)
		end 
	else
		print("ERROR ON OUTCOME")
	end
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