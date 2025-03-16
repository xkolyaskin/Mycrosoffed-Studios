extends Node2D

@onready var tile_map : TileMapLayer = $TileMapLayer


var carrying_seed = null
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
	tile_map = get_node_or_null("TileMapLayer")

	if tile_map == null:
		print("Error: TileMapLayer not found! Check the node name in the Scene Tree.")

func _process(delta): 
	if Input.is_action_just_pressed("interact"):
		var players = get_tree().get_nodes_in_group("player")
		if players.is_empty():
			print("Error: No player found in group!")
			return
		
		var player_pos = players[0].global_position
		var tile_map_pos : Vector2i = tile_map.local_to_map(player_pos)

		print("Player Tile:", tile_map_pos)
		debug_tile_data(tile_map_pos)
		handle_interaction(tile_map_pos)

func handle_interaction(tile_coords: Vector2i):
	var tile_data = tile_map.get_cell_tile_data(tile_coords)
	if not tile_data:
		return

	var is_pick_upable = tile_data.get_custom_data("Pick_Upable")
	var is_plantable = tile_data.get_custom_data("Plantable")
	var is_harvestable = tile_data.get_custom_data("Harvestable")
	var plant_name = tile_data.get_custom_data("Plant_Name")

	if is_pick_upable: 
		carrying_seed = plant_name
		print("Picked up seed:", carrying_seed)

	elif carrying_seed and is_plantable: 
		plant_seed(tile_coords, carrying_seed)

	elif is_harvestable:
		harvest_crop(tile_coords, plant_name)

func plant_seed(tile_coords: Vector2i, seed_type: String):
	# Set tile to "planted" state
	tile_map.set_cell(Vector2i(tile_coords.x, tile_coords.y), 0, Vector2i(0,0), TILE_SEED[seed_type])

	# Start growing the crop
	crop_growth[tile_coords] = { "seed_type": seed_type, "timer": 3 }  
	print("Planted", seed_type, "at", tile_coords)

	# Schedule growth
	await get_tree().create_timer(5.0).timeout 
	grow_crop(tile_coords)

func grow_crop(tile_coords: Vector2i):
	var seed_type = crop_growth[tile_coords]["seed_type"]
	if seed_type in TILE_GROWN_CROP:
		tile_map.set_cell(Vector2i(tile_coords.x, tile_coords.y), 0, Vector2i(0,0), TILE_GROWN_CROP[seed_type])
		print(seed_type, "has fully grown at", tile_coords)

	print(seed_type, "has fully grown at", tile_coords)

func harvest_crop(tile_coords: Vector2i, crop_type: String):
	# Remove the crop and reset the tile to farmland
	tile_map.set_cell(Vector2i(tile_coords.x, tile_coords.y), 0, Vector2i(0,0), TILE_FARMLAND)

	# Reset custom tile data safely
	var tile_data = tile_map.get_cell_tile_data(tile_coords)
	if tile_data:  # Ensure tile_data isn't null before setting values
		tile_data.set_custom_data("harvestable", false)
		tile_data.set_custom_data("plant_name", null)

	print("Harvested", crop_type, "at", tile_coords)

	# (Optional) Add harvested crop to player inventory

func pick_up_seed(seed_type, tile_coords):
	carrying_seed = seed_type
	tilemap.set_cell(0, tile_coords, -1)  # Remove the seed tile
	print("Picked up a", seed_type, "seed!")

func debug_tile_data(tile_coords: Vector2i):
	var tile_data = tile_map.get_cell_tile_data(tile_coords)
	if not tile_data:
		print("No tile data found at:", tile_coords)
		return

	print("Tile Data at", tile_coords, ":")
	print("  - Pick_Upable:", tile_data.get_custom_data("Pick_Upable"))
	print("  - Plantable:", tile_data.get_custom_data("Plantable"))
	print("  - Harvestable:", tile_data.get_custom_data("Harvestable"))
	print("  - Plant_Name:", tile_data.get_custom_data("Plant_Name"))

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
