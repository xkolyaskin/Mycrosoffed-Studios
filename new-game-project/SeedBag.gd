extends Area2D

@export var seed_type: String = "potato" 
@export var seed_sprite: Texture 
@onready var sprite = $Sprite2D

func _ready():
	sprite.texture = seed_sprite
	add_to_group("seed_bag")
	
	self.body_entered.connect(_on_body_entered)
	self.body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.is_in_group("player"):
		$Label.text = "Take " + seed_type + " seed"
		$Label.visible = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		$Label.visible = false
