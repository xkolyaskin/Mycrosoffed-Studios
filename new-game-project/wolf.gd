extends CharacterBody2D

@onready
var player = get_node("/root/reindeer_herding/Player")
@onready
var reindeer = get_node("/root/reindeer_herding/deer")

func _physics_process(delta: float) -> void:
	velocity=Vector2(0,0)
	
