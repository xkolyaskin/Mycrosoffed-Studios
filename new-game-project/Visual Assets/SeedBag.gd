extends Node2D

@export var seed_type: String = "potato"  # Default seed type
var player_nearby = false  # Track if the player is near

func _ready():
	add_to_group("seed_bag")

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_nearby = body  # Store the player reference
		print("Player is near the seed bag:", seed_type)

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_nearby = false  # Reset when the player leaves
		print("Player left the seed bag:", seed_type)

func _process(delta):
	if player_nearby and Input.is_action_just_pressed("interact"):
		player_nearby.pick_up_seed(seed_type)  # Call player function
		print("Player picked up:", seed_type)
