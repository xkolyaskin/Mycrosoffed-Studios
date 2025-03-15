extends Node2D
var numDeer = 5
var numLichen = 6
var numIceLichen = 0
var round = 0
var deerPositions = [
	[Vector2(496,-71),Vector2(-2,273),Vector2(310,365),Vector2(533,110),Vector2(832,99)]
]
var deer=[]
var lichenPositions = [
	[Vector2(617,281),Vector2(2,1),Vector2(-164,389),Vector2(319,80),Vector2(424,380),Vector2(574,-34)]
]
var lichen=[]
var iceLichen=[]
var iceLichenPositions = [
	
]

func _ready() -> void:
	$Player.position=Vector2(327,193)
	var reindeer = preload("res://reindeer.tscn")
	var lich = preload("res://lichen.tscn")
	for i in range (0,numLichen):
		var currentLichen = lich.instantiate()
		currentLichen.position=lichenPositions[round][i]
		add_child(currentLichen)
		lichen.append(currentLichen)
	for i in range (0,numDeer):
		var currentDeer = reindeer.instantiate()
		currentDeer.position=deerPositions[round][i]
		add_child(currentDeer)
		deer.append(currentDeer)


func atEnd():
	var score = 0
	for d in deer:
		score += d.score
