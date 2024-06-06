# FindTheWord.gd
extends Control

var grid = []
var word = "APPLE"

func _ready():
	_init_game()

func _init_game():
	_create_grid()
	_place_word()
	_play_audio("apple.mp3") # Example audio

func _create_grid():
	for i in range(6):
		var row = []
		for j in range(6):
			var letter = Label.new()
			letter.text = _random_letter()
			letter.rect_position = Vector2(i * 50, j * 50)
			add_child(letter)
			row.append(letter)
		grid.append(row)

func _random_letter():
	return chr(rand_range(65, 90))

func _place_word():
	# Implement logic to place the word in the grid
	pass

func _play_audio(audio_file):
	$AudioStreamPlayer.stream = load(audio_file)
	$AudioStreamPlayer.play()
