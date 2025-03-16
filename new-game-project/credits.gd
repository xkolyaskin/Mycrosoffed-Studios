extends Node2D
var height = -1896

func _ready() -> void:
	position=Vector2(0,0)
	var pms = float(-1*height)/600
	for i in range(0,600):
		await get_tree().create_timer(0.1).timeout
		position=position+Vector2(0,0-pms)
