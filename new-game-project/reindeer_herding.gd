extends Node2D
signal end_reindeer
var numDeer = 5
var numLichen = 8
var numWolves = 1
var round = 0
var deerPositions = [Vector2(496,-71),Vector2(-2,273),Vector2(310,365),Vector2(533,110),Vector2(832,99),Vector2(-84,-111),Vector2(597,410),Vector2(-25,377),Vector2(465,139)]
var deer=[]
var lichenPositions = [Vector2(617,281),Vector2(2,1),Vector2(-164,389),Vector2(574,-34),Vector2(269,359),Vector2(286,-187),Vector2(897,97),Vector2(319,80)]
var lichen=[]
var iceLichen=[]
var iceList=[]
var wolves = []
var wolfPositions = [Vector2(706,-197)]
var reindeer = preload("res://reindeer.tscn")
var lich = preload("res://lichen.tscn")
var iceLich = preload("res://ice_lichen.tscn")
var ice = preload("res://ice.tscn")
var wolf = preload("res://wolf.tscn")
@onready
var cloudAnim=$Cloud/am
var score=0

func _ready() -> void:
	beginRound(round)

func beginRound(round):
	score=0
	round = GlobalCountTracker.get_reindeer_round_count() - 1
	numDeer=GlobalCountTracker.get_reindeer_count()
	numLichen=GlobalCountTracker.get_lichen_count()
	print("herding " + str(round))
	$CanvasLayer/Score.text="Score: "+str(score) + "/50"
	$map.position=Vector2(-103,-68)
	$Player.position=Vector2(327,193)
	$Cloud.hide()
	cloudAnim.play("rain")
	for i in range(0,numWolves):
		var currentwolf = wolf.instantiate()
		add_child(currentwolf)
		wolves.append(currentwolf)
		currentwolf.position=wolfPositions[0]
	for i in range (0,numLichen):
		var currentLichen = lich.instantiate()
		currentLichen.position=lichenPositions[i]
		add_child(currentLichen)
		lichen.append(currentLichen)
	for i in range (0,numDeer):
		var currentDeer = reindeer.instantiate()
		currentDeer.position=deerPositions[i]
		add_child(currentDeer)
		deer.append(currentDeer)
	var cloudTime = 30/(round+1)
	timer()
	for i in range (0,round+1):
		cloudGo()
		await get_tree().create_timer(cloudTime).timeout
	atEnd()
	
	
func timer():
	for i in range(0,30):
		await get_tree().create_timer(1).timeout
		$CanvasLayer/Time.text="Time: "+str(30-i)

func cloudGo():
	$CanvasLayer/Done.hide()
	var index = randi_range(0,len(lichen)-1)
	var pos=lichen[index].position
	$Cloud.position=pos
	$Cloud.show()
	await get_tree().create_timer(10).timeout
	var i = ice.instantiate()
	i.position=$Cloud.position
	lichen[index].queue_free()
	lichen.remove_at(index)
	iceList.append(i)
	add_child(i)
	var il = iceLich.instantiate()
	il.position=pos
	iceLichen.append(il)
	add_child(il)
	$Cloud.hide()

func incScore():
	score+=1
	$CanvasLayer/Score.text="Score: "+str(score) + "/50"

func atEnd():
	for d in deer:
		d.queue_free()
	for l in lichen:
		l.queue_free()
	for il in iceLichen:
		il.queue_free()
	for i in iceList:
		i.queue_free()
	for w in wolves:
		w.queue_free()
	iceList=[]
	lichen=[]
	deer=[]
	iceLichen=[]
	GlobalCountTracker.set_reindeer_count(numDeer + 1)
	GlobalCountTracker.set_lichen_count(numLichen - 1)
	#$CanvasLayer/Done.text="Score: "+str(score)
	#$CanvasLayer/Done.show()
	#await get_tree().create_timer(3).timeout
	#$CanvasLayer/Done.hide()
	GlobalCountTracker.inc_reindeer_score(score)
	FadeToBlack.change_scene_with_fade("res://Game.tscn")
	#go back to lore guy
	#if round<3:
		#beginRound(round)
