-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.

function result_for_player(player_move, enemy_move)
	if player_move == "shield" then
		if enemy_move == "shield" then
			return "tie"
		elseif enemy_move == "scroll" then
			return "loss"
		elseif enemy_move == "sword" then
			return "win"
		elseif enemy_move == "special" then
			return "loss"
		end
	elseif player_move == "scroll" then
		if enemy_move == "shield" then
			return "win"
		elseif enemy_move == "scroll" then
			return "tie"
		elseif enemy_move == "sword" then
			return "loss"
		elseif enemy_move == "special" then
			return "loss"
		end
	elseif player_move == "sword" then
		if enemy_move == "shield" then
			return "loss"
		elseif enemy_move == "scroll" then
			return "win"
		elseif enemy_move == "sword" then
			return "tie"
		elseif enemy_move == "special" then
			return "loss"
		end
	elseif player_move == "special" then
		if enemy_move == "shield" then
			return "win"
		elseif enemy_move == "scroll" then
			return "win"
		elseif enemy_move == "sword" then
			return "win"
		elseif enemy_move == "special" then
			return "tie"
		end
	end
end
		