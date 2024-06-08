extends Control

var letters = []
var dragging_letter = null
var start_position = Vector2()

func _ready():
	_init_game()

func _init_game():
	var word = "CAT"
	letters = ["C", "A", "T"]
	letters.shuffle()
	_display_letters()
	_display_image("res://Assets/Cat.webp") 

func _display_letters():
	for letter in letters:
		var letter_node = Label.new()
		letter_node.text = letter
		letter_node.set_position(Vector2(randi_range(100, 400), randi_range(200, 400)))
		letter_node.mouse_filter = Control.MOUSE_FILTER_PASS
		add_child(letter_node)

		letter_node.connect("gui_input", Callable(self, "_on_Letter_gui_input"))

func _display_image(image_path):
	$Image.texture = load(image_path)

func _on_Letter_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		dragging_letter = event.target
		start_position = dragging_letter.get_position()
	elif event is InputEventMouseMotion and dragging_letter:
		dragging_letter.set_position(dragging_letter.get_position() + event.relative)
	elif event is InputEventMouseButton and not event.pressed and dragging_letter:
		if _is_correct_position(dragging_letter, dragging_letter.get_position()):
			dragging_letter.modulate = Color(0, 1, 0) 
		else:
			dragging_letter.set_position(start_position)
			dragging_letter.modulate = Color(1, 0, 0)
		dragging_letter = null

func _is_correct_position(letter_node, position):
	return true




