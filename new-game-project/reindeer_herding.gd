extends Node2D
var numDeer = 5
var round = 0
var deerPositions = [
	[Vector2(496,-71),Vector2(-2,273),Vector2(310,365),Vector2(533,110),Vector2(832,99)]
]

func _ready() -> void:
	var reindeer = preload("res://reindeer.tscn")
	for i in range (0,numDeer):
		var currentDeer = reindeer.instantiate()
		currentDeer.position=deerPositions[round][i]
		add_child(currentDeer)
