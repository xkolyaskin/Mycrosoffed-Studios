extends Node2D

@onready var dialogue_box = $DialogueBox

func _ready():
	while(true):
		if not dialogue_box.is_typing():
			dialogue_box.type_text("1st Round: While we do love our meat, a balanced diet requires some veggies too. Walk over to those seeds and choose which one to plant. ")
		if Input.is_action_just_pressed("interact") and not dialogue_box.is_typing(): 
			emit_signal("next_text")
			print("next")
			
	
