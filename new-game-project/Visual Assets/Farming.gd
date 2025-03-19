extends Node2D

@onready var player = $Player
var score = 0
var timer = 45
var round

func _ready():
	round = GlobalCountTracker.get_farming_count() + 1
	await get_tree().create_timer(0.1).timeout
	if round == 1:
		$Farmland7.hide()
		$Farmland7.set_plantable(false)
	if round == 2:
		$Farmland7.hide()
		$Farmland7.set_plantable(false)
		$Farmland4.hide()
		$Farmland4.set_plantable(false)
		$Farmland.hide()
		$Farmland.set_plantable(false)
		

func _on_timer_timeout():
	timer -= 1
	$"CanvasLayer/TimerLabel".text = "Timer: " + str(timer) 
	if timer == 0:
		GlobalCountTracker.inc_farming_score(score)
		FadeToBlack.change_scene_with_fade("res://Game.tscn")


func inc_score(num):
	score += num
	$"CanvasLayer/ScoreLabel".text = "Score: " + str(score) + "/100"
