extends Node2D

@export var seed_type: String = "potato"  # Set this in the editor (potato, beet, cabbage)
@export var seed_sprite: Texture  # Assign the sprite in the editor

@onready var sprite = $Sprite2D

func _ready():
	sprite.texture = seed_sprite

func _on_body_entered(body):
	if body.is_in_group("player"):
		$Label.text = "Take " + seed_type + " seed"
		$Label.visible = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		$Label.visible = false
