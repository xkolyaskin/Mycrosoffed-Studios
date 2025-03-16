extends Sprite2D
var going = false

func _ready() -> void:
	position=Vector2(-15,0)
	hide()

func go():
	if !going:
		going=true
		show()
		for i in range(1,15):
			await get_tree().create_timer(0.05).timeout
			position += Vector2(0,-2)
		hide()
		position=Vector2(-15,0)
		going=false
