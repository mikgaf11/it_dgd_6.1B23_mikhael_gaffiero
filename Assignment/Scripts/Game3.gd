extends Control

var words_folder = "res://Assets/Words"
var current_word = ""
var selected_word = ""
var letters = []
var letter_nodes = []
var audio_player = null
var audio_playing = false  

func _ready():
	randomize() 
	
	
	audio_player = get_node("AudioStreamPlayer2D")
	if audio_player == null:
		print("AudioStreamPlayer2D node not found")
	else:
		print("AudioStreamPlayer2D node found")

	load_random_word()
	
	var play_audio_button = get_node("Button")
	if play_audio_button:
		play_audio_button.connect("pressed", Callable(self, "_on_Button_pressed"))
	else:
		print("PlayAudioButton node not found")

func load_random_word():
	
	var grid_container = get_node("GridContainer")
	if grid_container:
		for node in grid_container.get_children():
			node.queue_free()
	else:
		print("GridContainer node not found")
		return

	letter_nodes.clear()
	letters.clear()
	selected_word = "" 

	
	var dir = DirAccess.open(words_folder)
	if dir == null:
		print("Failed to open words folder")
		return

	var word_folders = []
	dir.list_dir_begin()
	while true:
		var folder_name = dir.get_next()
		if folder_name == "":
			break
		if dir.current_is_dir() and folder_name != "." and folder_name != "..":
			word_folders.append(folder_name)
	dir.list_dir_end()

	
	if word_folders.size() == 0:
		print("No words found in folder")
		return

	var random_folder = word_folders[randi() % word_folders.size()]

	
	var audio_path = words_folder + "/" + random_folder + "/audio.mp3"
	var word_path = words_folder + "/" + random_folder + "/name.txt"
	
	
	print("Loading audio from: ", audio_path)
	print("Loading word from: ", word_path)

	if !FileAccess.file_exists(audio_path):
		print("Audio file not found: ", audio_path)
		return
	if !FileAccess.file_exists(word_path):
		print("Word file not found: ", word_path)
		return

	audio_player.stream = load(audio_path)
	var word_file = FileAccess.open(word_path, FileAccess.READ)
	if word_file == null:
		print("Failed to open word file")
		return

	current_word = word_file.get_as_text().strip_edges()
	word_file.close()

	
	var shuffled_letters = Array(current_word.split("") + "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split(""))
	shuffled_letters.shuffle()

	for letter in shuffled_letters:
		var letter_node = Button.new()
		letter_node.text = letter
		letter_node.custom_minimum_size = Vector2(50, 50)  
		grid_container.add_child(letter_node)
		letter_node.connect("pressed", Callable(self, "_on_letter_pressed").bind(letter_node))

		letter_nodes.append(letter_node)
		
	_play_audio()

func _play_audio():
	if !audio_playing:
		audio_player.play()
		audio_playing = true
		audio_player.connect("finished", Callable(self, "_on_audio_finished"))

func _on_audio_finished():
	audio_playing = false

func _on_letter_pressed(letter_node):
	var letter = letter_node.text
	selected_word += letter
	letter_node.disabled = true  
	check_completion()

func check_completion():
	var feedback_label = get_node("Label")
	if selected_word == current_word:
		if feedback_label:
			feedback_label.text = "Correct! The word is " + current_word
		call_deferred("load_random_word")  
	elif current_word.begins_with(selected_word):
		if feedback_label:
			feedback_label.text = "Keep going!"
	else:
		if feedback_label:
			feedback_label.text = "Incorrect! Try again."
		selected_word = ""
		for node in letter_nodes:
			node.disabled = false  


func _on_button_pressed():
	_play_audio()
