extends Control

func _ready():
	$StartGame1Button.connect("pressed", self, "_on_StartGame1Button_pressed")
	$StartGame2Button.connect("pressed", self, "_on_StartGame2Button_pressed")
	$StartGame3Button.connect("pressed", self, "_on_StartGame3Button_pressed")

func _on_StartGame1Button_pressed():
	get_tree().change_scene("res://Game1.tscn")

func _on_StartGame2Button_pressed():
	get_tree().change_scene("res://Game2.tscn")

func _on_StartGame3Button_pressed():
	get_tree().change_scene("res://Game3.tscn")
