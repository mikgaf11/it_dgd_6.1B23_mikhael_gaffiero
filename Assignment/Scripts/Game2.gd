extends Control

var images = ["res://Assets/Dog.png", "res://Assets/Cat.png", "res://Assets/Mouse.png"]
var word = "DOG"
var letters = ["D", "O", "G"]

func _ready():
	_init_game()

func _init_game():
	_display_images()
	_display_letters()

func _display_images():
	$Image1.texture = load(images[0])
	$Image2.texture = load(images[1])
	$Image3.texture = load(images[2])

func _display_letters():
	letters.shuffle()
	for letter in letters:
		var letter_node = Label.new()
		letter_node.text = letter
		letter_node.rect_position = Vector2(randf_range(100, 400), randf_range(200, 400))
		add_child(letter_node)

func _on_letter_dragged(letter_node, position):
	if _is_correct_position(letter_node, position):
		letter_node.rect_position = position
		letter_node.modulate = Color(0, 1, 0)
	else:
		letter_node.rect_position = letter_node.start_position
		letter_node.modulate = Color(1, 0, 0) 

func _is_correct_position(letter_node, position):
	return true
