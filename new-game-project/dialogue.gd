extends Node2D

@onready var dialogue_box = $DialogueBox
@onready var talking_audio = $Talking

var scene = 1
var dialogue1_1 = "While we do love our meat, a balanced diet requires some veggies too. Walk over to those seeds and choose which one to plant. "
var dialogue1_2 = "Once they are planted, wait for them to grow and harvest your crops before they go bad. Pick up/place using SPACE or E."

var randomDialogue = [
	"The Chawchu dance was one of my favorite things to watch and perform. I played the lalai drum, which I once broke by hitting it with my head.",
	"I once traveled from Tilichiki in a blizzard while being pulled by my blind dog, Dimitri. We had to cover ourselves in mud to hide from a bear.",
	"When I was a kid I loved sliding across the river ice with my friends. My friend Pepe once slid across on his bare stomach. He did not enjoy that.",
	"Did I ever tell you about my brothers? There were… uh… 20 of them. That would take too long to explain, I’ll tell you another time.",
	"Hey, have you seen my cane? I think it's buried in the snow somewhere around here.",
	"I once saw a reindeer so big I thought that even I could ride it. The reindeer thought otherwise.",
	"There was once a terrible blizzard that dumped so much snow it covered my entire house. It took me an entire day to dig myself out.",
	"I’ve heard rumors of a wild Purdue Pete fish in the rivers nearby…",
	"A recent visitor informed me of a tree that didn’t seem quite right.",
	"People often ask how I survive without my sight, let's just say I’m a really good elder.",
	"There’s something to be said about a salmon hot dog that most people just don’t understand.",
	"Where’s the fun in taking things one step at a time?"
]
var usedDialogue = []

func _ready():
	if get_tree().paused:
		await get_tree().tree_unpaused
	if scene == 1:
		await play_dialogue(dialogue1_1)
		print("next")
		await play_dialogue(dialogue1_2)
		print("next_scene")
		
		

func play_dialogue(string):
	if not dialogue_box.is_typing():
		dialogue_box.visible = true
		talking_audio.playing = true
		await dialogue_box.type_text(string)
		talking_audio.playing = false
	while(true):
		await get_tree().create_timer(0.01).timeout
		if Input.is_action_just_pressed("interact") and not dialogue_box.is_typing(): 
			dialogue_box.visible = false
			return
