extends Node2D
var height = -2700
var time = 170

func _ready() -> void:
	position=Vector2(0,0)
	await get_tree().create_timer(3).timeout
	var pms = float(-1*height)/(time*10)
	for i in range(0,time*10):
		await get_tree().create_timer(0.01).timeout
		position=position+Vector2(0,0-pms)
	GlobalCountTracker.reset()
	FadeToBlack.change_scene_with_fade("res://menu.tscn")
