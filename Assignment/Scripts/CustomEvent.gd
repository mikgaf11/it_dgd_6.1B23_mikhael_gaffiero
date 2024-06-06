extends Node
signal word_completed

# Singleton setup
func _init():
	pass

# MatchAndLearn.gd
func _on_word_completed():
	emit_signal("word_completed")
