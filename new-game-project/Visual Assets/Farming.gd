extends Node2D

@onready var tile_map : TileMapLayer = $TileMapLayer
var planted_crops = {} 
var crop_growth_time = 5 
var crop_stages = 3 

var crop_sprites = {  # Placeholder for different crop sprites
	"potato": ["res://Visual Assets/Backgrounds/Potato Sprout Farmland Background Texture.png", "res://Visual Assets/Backgrounds/Potato Grown Farmland Background Texture.png"],
	"beet": ["res://Visual Assets/Backgrounds/Beet Sprout Farmland Background Texture.png", "res://Visual Assets/Backgrounds/Beet Grown Farmland Background Texture.png"],
	"cabbage": ["res://Visual Assets/Backgrounds/Cabbage Seeds Farmland Background Texture.png", "res://Visual Assets/Backgrounds/Cabbage Grown Farmland Background Texture.png"]
}

func _process(delta):
	if Input.is_action_just_pressed("interact"):
		var player = get_tree().get_first_node_in_group("player")
		
