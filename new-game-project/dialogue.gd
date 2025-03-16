extends Node2D

@onready var dialogue_box = $DialogueBox
@onready var talking_audio = $Talking

var scene = 1
var dialogue1_1 = "While we do love our meat, a balanced diet requires some veggies too. Walk over to those seeds and choose which one to plant. "
var dialogue1_2 = "Once they are planted, wait for them to grow and harvest your crops before they go bad. Pick up/place using SPACE or E."


func _ready():
	
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
