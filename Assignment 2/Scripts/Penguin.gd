extends Area2D

var player = 0

func _input(event):
	if event is InputEventMouseButton and event.pressed and player == get_parent().player_turn:
		_move_to_tile(get_global_mouse_position())

func _move_to_tile(position):
	var tile = _get_tile_at_position(position)
	if tile and tile.fish > 0:
		position = tile.position
		_collect_fish(tile.fish)
		tile.set_fish(0)  # Remove tile
		if not get_parent()._any_moves_left():
			get_parent()._end_game()
		else:
			get_parent().player_turn = 2 if get_parent().player_turn == 1 else 1  # Switch turns

func _collect_fish(fish):
	if player == 1:
		get_parent().player1_score += fish
	else:
		get_parent().player2_score += fish

func _get_tile_at_position(position):
	var x = int(position.x / 50)
	var y = int(position.y / 50)
	if x >= 0 and x < get_parent().board_size and y >= 0 and y < get_parent().board_size:
		return get_parent().tiles[x][y]
	return null

