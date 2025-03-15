extends Node2D

@onready var tile_map : TileMapLayer = $TileMapLayer


var carrying_seed = null
var current_tile = null 
var tilemap
var crop_growth = {}
	
const TILE_SEED = {
	"potato": 1,
	"turnip": 2,
	"cabbage": 3
}
const TILE_FARMLAND = 4
const TILE_GROWN_CROP = {
	"potato": 5,
	"turnip": 6,
	"cabbage": 7
}

	
func _ready():
	var tilemap_layer = get_parent().find_child("TileMapLayer")

	if tilemap_layer == null:
		print("Error: TileMapLayer not found! Check the node name.")
		return

	# Get the parent TileMap (since TileMapLayer is a child of TileMap)
	tile_map = tilemap_layer.get_parent() 

	if tile_map == null:
		print("Error: TileMap not found! Ensure TileMapLayer has a parent TileMap.")

func _process(delta): 
	if Input.is_action_just_pressed("interact"):
		var players = get_tree().get_nodes_in_group("player")
		if players.size() == 0:
			print("Error: No player found in group!")
			return  # Exit the function if no player exists
		var player_pos = players[0].global_position
		var tile_map_pos : Vector2i = tile_map.local_to_map(player_pos)
		print("Player Tile:", tile_map_pos)
		# handle_interaction(tile_map_pos)
		
"""
func handle_interaction():
	if not tilemap or not current_tile:
		return

	var tile_coords = tilemap.local_to_map(current_tile)
	var tile_id = tilemap.get_cell_source_id(0, tile_coords)  # Get tile ID from layer 0

	# Picking up a seed
	for seed_type in TILE_SEED.keys():
		if tile_id == TILE_SEED[seed_type] and not carrying_seed:
			pick_up_seed(seed_type, tile_coords)
			return
	
	# Planting a seed
	if tile_id == TILE_FARMLAND and carrying_seed:
		plant_seed(tile_coords)
		return

	# Harvesting a grown crop
	for crop_type in TILE_GROWN_CROP.keys():
		if tile_id == TILE_GROWN_CROP[crop_type]:
			harvest_crop(tile_coords, crop_type)
			return

func pick_up_seed(seed_type, tile_coords):
	carrying_seed = seed_type
	tilemap.set_cell(0, tile_coords, -1)  # Remove the seed tile
	print("Picked up a", seed_type, "seed!")

func plant_seed(tile_coords):
	crop_growth[tile_coords] = { "seed_type": carrying_seed, "timer": 3 }  # Set a growth timer
	carrying_seed = null
	print("Planted", crop_growth[tile_coords]["seed_type"], "!")

	# Start crop growthgit

func grow_crop(tile_coords):
	var seed_type = crop_growth[tile_coords]["seed_type"]
	tilemap.set_cell(0, tile_coords, TILE_GROWN_CROP[seed_type])  # Change tile to grown crop
	print(seed_type, "has fully grown!")

func harvest_crop(tile_coords, crop_type):
	tilemap.set_cell(0, tile_coords, TILE_FARMLAND)  # Reset to farmland
	print("Harvested a", crop_type, "!")
"""
