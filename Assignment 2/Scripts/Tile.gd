extends Area2D

var fish = 0
var fish_texture = preload("res://Assets/Fish.png")

func set_fish(count):
	fish = count
	$FishLabel.text = str(fish)
	_update_visual()

func _ready():
	_update_visual()

func _update_visual():
	
	if fish > 0:
		$FishSprite.texture = fish_texture
	else:
		$FishSprite.texture = null



