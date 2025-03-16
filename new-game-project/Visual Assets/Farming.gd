extends Node2D
@onready var seed_bags = [$PotatoSeedBag, $BeetSeedBag, $CabbageSeedBag]
@onready var player = get_tree().get_first_node_in_group("player")
@onready var floating_text = player.get_node("FloatingText") if player else null
var held_seed = null
var crop_sprites = {
	"potato": ["res://Visual Assets/Backgrounds/Potato Sprout Farmland Background Texture.png", "res://Visual Assets/Backgrounds/Potato Grown Farmland Background Texture.png"],
	"beet": ["res://Visual Assets/Backgrounds/Beet Sprout Farmland Background Texture.png", "res://Visual Assets/Backgrounds/Beet Grown Farmland Background Texture.png"],
	"cabbage": ["res://Visual Assets/Backgrounds/Cabbage Seeds Farmland Background Texture.png", "res://Visual Assets/Backgrounds/Cabbage Grown Farmland Background Texture.png"]
}

func _process(delta):
	for seed_bag in seed_bags:
		var area = seed_bag.get_node_or_null("Area2D")
		if area and area.has_overlapping_bodies():
			display_seed_text(seed_bag.name)
			update_text_position($SeedText, Vector2(-70, 180))
			return
	hide_seed_text()

func display_seed_text(seed_name):
	var seed_type = seed_name.replace("SeedBag", "")
	$SeedText.text = "[E] Take " + seed_type + " Seed"
	$SeedText.visible = true

func hide_seed_text():
	if $SeedText:
		$SeedText.visible = false
		
func update_text_position(label: Label, offset: Vector2):
	if label and player:
		label.global_position = player.global_position + offset
