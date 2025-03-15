extends Node2D



func _ready():
	spawn_fishing_spot()
	spawn_fishing_spot()
	spawn_fishing_spot()
	spawn_fishing_spot()
	spawn_fishing_spot()
	spawn_fishing_spot()
	spawn_fishing_spot()
	spawn_fishing_spot()
	spawn_fishing_spot()
	
func spawn_fishing_spot():
	var new_spot = preload("res://fishing_spot.tscn").instantiate()
	
	%FishingPath.progress_ratio = randf()
	%FishingPath.global_position /= 32
	%FishingPath.global_position *= 32
	new_spot.global_position = %FishingPath.global_position
	add_child(new_spot)

func create_crack():
	var new_spot = preload("res://fishing_crack.tscn").instantiate()
	%FishingPath.progress_ratio = randf()
	new_spot.global_position = %FishingPath.global_position
	add_child(new_spot)

func _on_timer_timeout():
	create_crack();
	
