extends Control

var letters = []
var correct_positions = []
var current_word = "CAT"
var images = ["res://image1.png", "res://image2.png", "res://image3.png"]
var image_index = 0

func _ready():
	letters = [$Letter1, $Letter2, $Letter3]
	correct_positions = [Vector2(200, 400), Vector2(300, 400), Vector2(400, 400)]
	randomize_letters()
	$Image.texture = load(images[image_index])

func randomize_letters():
	var positions = []
	for i in range(letters.size()):
		var pos = Vector2(randi() % 800, randi() % 600)
		positions.append(pos)
		letters[i].rect_position = pos
		letters[i].connect("gui_input", self, "_on_Letter_gui_input")

func _on_Letter_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		var letter = event.get_target()
		letter.start_drag(Vector2(50, 50))

func _process(delta):
	for i in range(letters.size()):
		if letters[i].rect_position.distance_to(correct_positions[i]) < 50:
			letters[i].rect_position = correct_positions[i]
			letters[i].modulate = Color(0, 1, 0)

	if check_letters_in_correct_positions():
		move_to_next_image()

func check_letters_in_correct_positions():
	for i in range(letters.size()):
		if letters[i].rect_position != correct_positions[i]:
			return false
	return true

func move_to_next_image():
	image_index += 1
	if image_index < images.size():
		$Image.texture = load(images[image_index])
		current_word = "NEW_WORD"  # Set the new word here
		correct_positions = [Vector2(200, 400), Vector2(300, 400), Vector2(400, 400)]  # Set new positions
		randomize_letters()
	else:
		print("Game completed!")
