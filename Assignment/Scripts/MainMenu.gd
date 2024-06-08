extends Control

func _ready():
	$StartGame1Button.connect("pressed", Callable(self, "_on_start_game_1_button_pressed"))
	$StartGame2Button.connect("pressed", Callable(self, "_on_start_game_2_button_pressed"))
	$StartGame3Button.connect("pressed", Callable(self, "_on_start_game_3_button_pressed"))




func _on_start_game_1_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Game1.tscn")

func _on_start_game_2_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Game2.tscn")

func _on_start_game_3_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Game3.tscn")
