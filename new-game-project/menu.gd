extends Node2D

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_play_pressed() -> void:
	FadeToBlackSpecial.change_scene_with_fade("res://Game.tscn")
