extends Node2D

var board_size = 8
var tiles = []
var fish_count = [1, 1, 1, 2, 2, 3]
var player_turn = 1
var player1_penguins = []
var player2_penguins = []
var player1_score = 0
var player2_score = 0

# Preload scenes
var TileScene = preload("res://Scenes/Tile.tscn")
var PenguinScene = preload("res://Scenes/Penguin.tscn")

func _ready():
	_create_board()
	_shuffle_fish()
	_initialize_penguins()
	_play_audio("res://Assets/background.mp3")

func _create_board():
	for x in range(board_size):
		var row = []
		for y in range(board_size):
			var tile = TileScene.instance()
			tile.position = Vector2(x * 50, y * 50)
			add_child(tile)
			row.append(tile)
		tiles.append(row)

func _shuffle_fish():
	for row in tiles:
		for tile in row:
			tile.set_fish(fish_count[randi() % fish_count.size()])

func _initialize_penguins():
	for i in range(4):
		var penguin1 = PenguinScene.instance()
		penguin1.player = 1
		penguin1.position = _get_random_starting_position()
		player1_penguins.append(penguin1)
		add_child(penguin1)

		var penguin2 = PenguinScene.instance()
		penguin2.player = 2
		penguin2.position = _get_random_starting_position()
		player2_penguins.append(penguin2)
		add_child(penguin2)

func _get_random_starting_position():
	while true:
		var pos = Vector2(randi() % board_size, randi() % board_size)
		if tiles[pos.x][pos.y].fish == 1:
			return pos

func _any_moves_left():
	for penguin in player1_penguins + player2_penguins:
		if _can_move(penguin):
			return true
	return false

func _can_move(penguin):
	var directions = [Vector2(1, 0), Vector2(-1, 0), Vector2(0, 1), Vector2(0, -1), Vector2(1, 1), Vector2(-1, -1)]
	for dir in directions:
		var pos = penguin.position + dir * 50
		if _is_valid_tile(pos):
			return true
	return false

func _is_valid_tile(pos):
	var x = int(pos.x / 50)
	var y = int(pos.y / 50)
	return x >= 0 and x < board_size and y >= 0 and y < board_size and tiles[x][y].fish > 0

func _end_game():
	if player1_score > player2_score:
		print("Player 1 wins with ", player1_score, " fish!")
	else:
		print("Player 2 wins with ", player2_score, " fish!")

func _play_audio(audio_file):
	$AudioStreamPlayer.stream = load(audio_file)
	$AudioStreamPlayer.play()
