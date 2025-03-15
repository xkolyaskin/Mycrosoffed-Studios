extends Node2D

var score = 0

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
	%FishingPath.global_position = %FishingPath.global_position.snapped(Vector2(64,64))
	new_spot.global_position = %FishingPath.global_position
	add_child(new_spot)

func create_crack():
	var new_spot = preload("res://fishing_crack.tscn").instantiate()
	%FishingPath.progress_ratio = randf()
	%FishingPath.global_position = %FishingPath.global_position.snapped(Vector2(64,64))
	new_spot.global_position = %FishingPath.global_position
	add_child(new_spot)
	
func inc_score():
	score += 1
	$CanvasLayer/ScoreCount.text = ": " + str(score)

func _on_timer_timeout():
	create_crack();
	
func _on_timeleft_inc():
	
