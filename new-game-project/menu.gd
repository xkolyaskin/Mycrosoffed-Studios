extends Node2D

func _ready() -> void:
	$Play.show()
	$Quit.show()
	$Resources.show()
	$List.hide()

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_play_pressed() -> void:
	FadeToBlackSpecial.change_scene_with_fade("res://Game.tscn",false)

func _on_resources_pressed() -> void:
	$Play.hide()
	$Quit.hide()
	$Resources.hide()
	$List.show()


func _on_list_pressed() -> void:
	$Play.show()
	$Quit.show()
	$Resources.show()
	$List.hide()
