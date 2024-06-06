extends Control

var button_scene_map = {
	"StartGame1Button": "res://Game1.tscn",
	"StartGame2Button": "res://Scene2.tscn",
	"StartGame3Button": "res://Scene3.tscn"
}


func Button_pressed(button_name):
	# Load the corresponding scene
	var new_scene = load(button_scene_map[button_name])
	# Change the current scene to the new scene
	get_tree().change_scene_to(new_scene)

func _ready():
	$StartGame1Button.connect("pressed", Callable(self, "_on_start_game_1_button_pressed"))
	$StartGame2Button.connect("pressed", Callable(self, "_on_start_game_2_button_pressedd"))
	$StartGame3Button.connect("pressed", Callable(self, "_on_start_game_3_button_pressed"))



func _on_start_game_1_button_pressed():
	Button_pressed("StartGame1Button")

func _on_start_game_2_button_pressed():
	Button_pressed("StartGame2Button")

func _on_start_game_3_button_pressed():
	Button_pressed("StartGame2Button")
