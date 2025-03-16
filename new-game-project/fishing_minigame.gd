extends Node2D

var timer = 5
var score = 0
var crack_count = 0
var game_number
var speeds = [5, 2.5, 1.25]

func _ready():
	game_number = GlobalCountTracker.get_fishing_count() - 1
	print("fishing round" + str(game_number))
	$CrackTimer.wait_time = speeds[game_number]
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
	crack_count += 1
	if crack_count % 3 == 0:
		$"Ice-cracking-field-recording-06-139709".play()
	
func _on_timeleft_inc():
	timer -= 1
	$CanvasLayer/TimeLeft.text = "Timer: " + str(timer)
	if timer == 0:
		GlobalCountTracker.inc_fishing_score(score)
		FadeToBlack.change_scene_with_fade("res://Game.tscn")
