extends Node2D

@export var seed_type: String = "beet"

func _ready():
	add_to_group("seed_bag")

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.pick_up_seed(seed_type)
