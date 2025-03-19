extends Node2D

var timer = 45
var score = 0
var crack_count = 0
var game_number
var speeds = [3, 1.2, 0.8]


const WIDTH = 18
const HEIGHT = 10

var grid = []


func _ready():
	for y in range(HEIGHT):
		var row = []
		for x in range(WIDTH):
			row.append(false)
		grid.append(row)
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
	
	

func get_random_empty_tile() -> Vector2:
	var x = randi_range(0, WIDTH-1)
	var y = randi_range(0, HEIGHT-1)
	var attempt = grid_to_world(x, y)
	while (grid[y][x]):
		x = randi_range(0, WIDTH-1)
		y = randi_range(0, HEIGHT-1)
		attempt = grid_to_world(x, y)
	grid[y][x] = true
	return attempt

func grid_to_world(x: int, y: int) -> Vector2:
	return Vector2(32 + x * 64, 32 + y * 64)

func spawn_fishing_spot():
	var new_spot = preload("res://fishing_spot.tscn").instantiate()
	
	new_spot.global_position = get_random_empty_tile()
	add_child(new_spot)

func create_crack():
	var new_spot = preload("res://fishing_crack.tscn").instantiate()
	new_spot.global_position = get_random_empty_tile()
	add_child(new_spot)
	
func inc_score(x: int = 1):
	score += x
	$CanvasLayer/ScoreCount.text = ": " + str(score) + "/20"

func _on_timer_timeout():
	create_crack();
	crack_count += 1
	if crack_count % 7 == 0:
		$"Ice-cracking-field-recording-06-139709".play()
	
func _on_timeleft_inc():
	timer -= 1
	$CanvasLayer/TimeLeft.text = "Timer: " + str(timer)
	if timer == 0:
		GlobalCountTracker.inc_fishing_score(score)
		FadeToBlack.change_scene_with_fade("res://Game.tscn")
