
extends Control

var letters = []

func _ready():
	_init_game()

func _init_game():
	var word = "CAT"
	letters = ["C", "A", "T"]
	letters.shuffle()
	_display_letters()
	_display_image("res://Assets/Cat.png") 

func _display_letters():
	for letter in letters:
		var letter_node = Label.new()
		letter_node.text = letter
		letter_node.rect_position = Vector2(randf_range(100, 400), randf_range(200, 400))
		add_child(letter_node)

func _display_image(image_path):
	$Image.texture = load(image_path)

func _on_letter_dragged(letter_node, position):
	if _is_correct_position(letter_node, position):
		letter_node.rect_position = position
		letter_node.modulate = Color(0, 1, 0) 
	else:
		letter_node.rect_position = letter_node.start_position
		letter_node.modulate = Color(1, 0, 0) 

func _is_correct_position(letter_node, position):
	
	return true
