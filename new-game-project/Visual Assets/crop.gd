extends Node2D

@export var crop_type: String = "potato"
@onready var sprite = $Sprite2D
var growth_stage = 0
var is_ready_to_harvest = false

# Crop sprites for different growth stages
var crop_sprites = {
	"potato": ["res://Visual Assets/Backgrounds/Potato Sprout Farmland Background Texture.png", "res://Visual Assets/Backgrounds/Cabbage Seeds Farmland Background Texture.png"],
	"turnip": ["res://Visual Assets/Backgrounds/Beet Sprout Farmland Background Texture.png", "res://Visual Assets/Backgrounds/Beet Grown Farmland Background Texture.png"],
	"cabbage": ["res://Visual Assets/Backgrounds/Cabbage Seeds Farmland Background Texture.png", "res://Visual Assets/Backgrounds/Cabbage Grown Farmland Background Texture.png"]
}

func _ready():
	sprite.texture = load(crop_sprites[crop_type][0]) 
	grow_crop()

func grow_crop():
	if growth_stage < 2:
		growth_stage += 1
		sprite.texture = load(crop_sprites[crop_type][growth_stage])  
		await get_tree().create_timer(5.0).timeout 
		grow_crop()
	else:
		is_ready_to_harvest = true
		print(crop_type, "is ready to harvest!")

func harvest():
	if is_ready_to_harvest:
		print("Harvested:", crop_type)
		queue_free() 
