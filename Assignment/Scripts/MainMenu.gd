extends Control

func _on_start_game_1_button_pressed():
	print("Start Game 1 button pressed")
	get_tree().change_scene("res://Scenes/Game1.tscn")

func _on_start_game_2_button_pressed():
	print("Start Game 2 button pressed")
	get_tree().change_scene("res://Scenes/Game2.tscn")

func _on_start_game_3_button_pressed():
	print("Start Game 3 button pressed")
	get_tree().change_scene("res://Scenes/Game3.tscn")

