extends Node2D
signal end_reindeer
var numDeer = 5
var numLichen = 8
var round = 0
var deerPositions = [
	[Vector2(496,-71),Vector2(-2,273),Vector2(310,365),Vector2(533,110),Vector2(832,99)],
	[Vector2(496,-71),Vector2(-2,273),Vector2(310,365),Vector2(533,110),Vector2(832,99)],
	[Vector2(496,-71),Vector2(-2,273),Vector2(310,365),Vector2(533,110),Vector2(832,99)]
]
var deer=[]
var lichenPositions = [
	[Vector2(617,281),Vector2(2,1),Vector2(-164,389),Vector2(319,80),Vector2(897,97),Vector2(574,-34),Vector2(269,359),Vector2(286,-187)],[Vector2(617,281),Vector2(2,1),Vector2(-164,389),Vector2(319,80),Vector2(897,97),Vector2(574,-34),Vector2(269,359),Vector2(286,-187)],[Vector2(617,281),Vector2(2,1),Vector2(-164,389),Vector2(319,80),Vector2(897,97),Vector2(574,-34),Vector2(269,359),Vector2(286,-187)],[Vector2(617,281),Vector2(2,1),Vector2(-164,389),Vector2(319,80),Vector2(897,97),Vector2(574,-34),Vector2(269,359),Vector2(286,-187)],[Vector2(617,281),Vector2(2,1),Vector2(-164,389),Vector2(319,80),Vector2(897,97),Vector2(574,-34),Vector2(269,359),Vector2(286,-187)],[Vector2(617,281),Vector2(2,1),Vector2(-164,389),Vector2(319,80),Vector2(897,97),Vector2(574,-34),Vector2(269,359),Vector2(286,-187)],[Vector2(617,281),Vector2(2,1),Vector2(-164,389),Vector2(319,80),Vector2(897,97),Vector2(574,-34),Vector2(269,359),Vector2(286,-187)],
	[Vector2(617,281),Vector2(2,1),Vector2(-164,389),Vector2(897,97),Vector2(574,-34),Vector2(269,359),Vector2(286,-187)],[Vector2(617,281),Vector2(2,1),Vector2(-164,389),Vector2(319,80),Vector2(897,97),Vector2(574,-34),Vector2(269,359),Vector2(286,-187)],[Vector2(617,281),Vector2(2,1),Vector2(-164,389),Vector2(319,80),Vector2(897,97),Vector2(574,-34),Vector2(269,359),Vector2(286,-187)],[Vector2(617,281),Vector2(2,1),Vector2(-164,389),Vector2(319,80),Vector2(897,97),Vector2(574,-34),Vector2(269,359),Vector2(286,-187)],[Vector2(617,281),Vector2(2,1),Vector2(-164,389),Vector2(319,80),Vector2(897,97),Vector2(574,-34),Vector2(269,359),Vector2(286,-187)],[Vector2(617,281),Vector2(2,1),Vector2(-164,389),Vector2(319,80),Vector2(897,97),Vector2(574,-34),Vector2(269,359),Vector2(286,-187)],[Vector2(617,281),Vector2(2,1),Vector2(-164,389),Vector2(319,80),Vector2(897,97),Vector2(574,-34),Vector2(269,359),Vector2(286,-187)],
	[Vector2(617,281),Vector2(2,1),Vector2(-164,389),Vector2(319,80),Vector2(574,-34),Vector2(269,359),Vector2(286,-187)],[Vector2(617,281),Vector2(2,1),Vector2(-164,389),Vector2(319,80),Vector2(897,97),Vector2(574,-34),Vector2(269,359),Vector2(286,-187)],[Vector2(617,281),Vector2(2,1),Vector2(-164,389),Vector2(319,80),Vector2(897,97),Vector2(574,-34),Vector2(269,359),Vector2(286,-187)],[Vector2(617,281),Vector2(2,1),Vector2(-164,389),Vector2(319,80),Vector2(897,97),Vector2(574,-34),Vector2(269,359),Vector2(286,-187)],[Vector2(617,281),Vector2(2,1),Vector2(-164,389),Vector2(319,80),Vector2(897,97),Vector2(574,-34),Vector2(269,359),Vector2(286,-187)],[Vector2(617,281),Vector2(2,1),Vector2(-164,389),Vector2(319,80),Vector2(897,97),Vector2(574,-34),Vector2(269,359),Vector2(286,-187)],[Vector2(617,281),Vector2(2,1),Vector2(-164,389),Vector2(319,80),Vector2(574,-34),Vector2(269,359),Vector2(286,-187)]
]
var lichen=[]
var iceLichen=[]
var reindeer = preload("res://reindeer.tscn")
var lich = preload("res://lichen.tscn")
var iceLich = preload("res://ice_lichen.tscn")

func _ready() -> void:
	beginRound(round)

func beginRound(round):
	$map.position=Vector2(-103,-68)
	$Player.position=Vector2(327,193)
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
	await get_tree().create_timer(60).timeout
	atEnd()
	


func atEnd():
	var score = 0
	for d in deer:
		score += d.score
		d.queue_free()
	for l in lichen:
		l.queue_free()
	for il in iceLichen:
		il.queue_free()
	lichen=[]
	deer=[]
	iceLichen=[]
	round+=1
	#numDeer += 2
	numLichen -= 1
	end_reindeer.emit(score)
	score=0
	await get_tree().create_timer(5).timeout
	if round<3:
		beginRound(round)
