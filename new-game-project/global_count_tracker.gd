extends Node

var dialogue_count = 0
var fishing_count = 0
var reindeer_round_count = 0
var farming_count = 0
var reindeer_count = 5
var lichen_count=8

var reindeer_score = 1110
var fishing_score = 1110
var farming_score = 1110

var randomDialogue = [
	"The Chawchu dance was one of my favorite things to watch and perform. I played the lalai drum, which I once broke by hitting it with my head.",
	"I once traveled from Tilichiki in a blizzard while being pulled by my blind dog, Dimitri. We had to cover ourselves in mud to hide from a bear.",
	"When I was a kid I loved sliding across the river ice with my friends. My friend Pepe once slid across on his bare stomach. He did not enjoy that.",
	"Did I ever tell you about my brothers? There were… uh… 20 of them. That would take too long to explain, I’ll tell you another time.",
	"Hey, have you seen my cane? I think it's buried in the snow somewhere around here.",
	"I once saw a reindeer so big I thought that even I could ride it. The reindeer thought otherwise.",
	"There was once a terrible blizzard that dumped so much snow it covered my entire house. It took me an entire day to dig myself out.",
	"I’ve heard rumors of a wild Purdue Pete fish in the rivers nearby…",
	"People often ask how I survive without my sight, let's just say I’m a really good elder.",
	"There’s something to be said about a salmon hot dog that most people just don’t understand.",
	"Where’s the fun in taking things one step at a time?",
	"We used to get enough snow to build a city when I was young. There’s only enough for a town these days.",
	"We get our power from oil, which I’ve been told is ‘not cool anymore’."
]

func get_dialogue_count():
	dialogue_count += 1
	return dialogue_count
	
func get_fishing_count():
	fishing_count += 1
	return fishing_count

func get_reindeer_round_count():
	reindeer_round_count += 1
	return reindeer_round_count
	
func get_reindeer_count():
	return reindeer_count;
	
func set_reindeer_count(num):
	reindeer_count=num

func get_lichen_count():
	return lichen_count

func set_lichen_count(num):
	lichen_count=num

func get_farming_count():
	farming_count += 1
	return farming_count

func inc_farming_score(score):
	farming_score += score

func inc_fishing_score(score):
	fishing_score += score
	
func inc_reindeer_score(score):
	reindeer_score += score
	
func get_random_dialogue():
	return randomDialogue

func set_random_dialogue(set):
	randomDialogue=set
	
func score_is_good() -> bool:
	return (fishing_score >= 25 and farming_score >= 150 and reindeer_score >= 150)
