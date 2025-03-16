extends Node2D

@onready var player = $Player
var score = 0
var timer = 45

func _on_timer_timeout():
	timer -= 1
	$"CanvasLayer/TimerLabel".text = "Timer: " + str(timer) 
	if timer == 0:
		GlobalCountTracker.inc_farming_score(score)
		FadeToBlack.change_scene_with_fade("res://Game.tscn")


func inc_score(num):
	score += num
	$"CanvasLayer/ScoreLabel".text = "Score: " + str(score) 
