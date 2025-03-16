extends Node2D
var height = -2200
var time = 30

func _ready() -> void:
	position=Vector2(0,0)
	await get_tree().create_timer(3).timeout
	var pms = float(-1*height)/(time*10)
	for i in range(0,time*10):
		await get_tree().create_timer(0.1).timeout
		position=position+Vector2(0,0-pms)
	print("End")
